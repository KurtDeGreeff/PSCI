data LocalizedData
{
    # culture="en-US"
    ConvertFrom-StringData @'
SetTargetResourceInstallwhatIfMessage=Trying to create website "{0}".
SetTargetResourceUnInstallwhatIfMessage=Trying to remove website "{0}".
WebsiteNotFoundError=The requested website "{0}" is not found on the target machine.
WebsiteDiscoveryFailureError=Failure to get the requested website "{0}" information from the target machine.
WebsiteCreationFailureError=Failure to successfully create the website "{0}".
WebsiteRemovalFailureError=Failure to successfully remove the website "{0}".
WebsiteUpdateFailureError=Failure to successfully update the properties for website "{0}".
WebsiteBindingUpdateFailureError=Failure to successfully update the bindings for website "{0}".
WebsiteBindingInputInvalidationError=Desired website bindings not valid for website "{0}".
WebsiteCompareFailureError=Failure to successfully compare properties for website "{0}".
WebBindingCertifcateError=Failure to add certificate to web binding. Please make sure that the certificate thumbprint "{0}" is valid.
WebsiteStateFailureError=Failure to successfully set the state of the website {0}.
WebsiteBindingConflictOnStartError = Website "{0}" could not be started due to binding conflict. Ensure that the binding information for this website does not conflict with any existing website's bindings before trying to start it.
'@
}

# The Get-TargetResource cmdlet is used to fetch the status of role or Website on the target machine.
# It gives the Website info of the requested role/feature on the target machine.  
function Get-TargetResource 
{
    param 
    (   
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )

        $getTargetResourceResult = $null;

        # Check if WebAdministration module is present for IIS cmdlets
        if(!(Get-Module -ListAvailable -Name WebAdministration))
        {
            Throw "Please ensure that WebAdministration module is installed."
        }

        if (!(Get-Module -Name WebAdministration -ErrorAction SilentlyContinue)) {
            Import-Module -Name WebAdministration -Verbose:$false
        }
        $Website = Get-Item "IIS:\sites\$Name" -ErrorAction SilentlyContinue

        if ($Website.count -eq 0) # No Website exists with this name.
        {
            $ensureResult = "Absent";
        }
        elseif ($Website.count -eq 1) # A single Website exists with this name.
        {
            $ensureResult = "Present"

            [PSObject[]] $Bindings
            $Bindings = (get-itemProperty -path IIS:\Sites\$Name -Name Bindings).collection

            $CimBindings = foreach ($binding in $bindings)
            {
                $BindingObject = get-WebBindingObject -BindingInfo $binding
                New-CimInstance -ClassName OBJ_cWebBindingInformation -Namespace root/microsoft/Windows/DesiredStateConfiguration -Property @{Port=[System.UInt16]$BindingObject.Port;Protocol=$BindingObject.Protocol;IPAddress=$BindingObject.IPaddress;HostName=$BindingObject.Hostname;CertificateThumbprint=$BindingObject.CertificateThumbprint;CertificateStoreName=$BindingObject.CertificateStoreName} -ClientOnly
            }

	   $allDefaultPage = @(Get-WebConfiguration //defaultDocument/files/*  -PSPath (Join-Path "IIS:\sites\" $Name) -ErrorAction SilentlyContinue |%{Write-Output $_.value})

        }
        else # Multiple websites with the same name exist. This is not supported and is an error
        {
            $errorId = "WebsiteDiscoveryFailure"; 
            $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
            $errorMessage = $($LocalizedData.WebsiteUpdateFailureError) -f ${Name} 
            $exception = New-Object System.InvalidOperationException $errorMessage 
            $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

            $PSCmdlet.ThrowTerminatingError($errorRecord);
        }

        # Add all Website properties to the hash table
        $getTargetResourceResult = @{
    	                                Name = $Website.Name; 
                                        Ensure = $ensureResult;
                                        PhysicalPath = $Website.physicalPath;
                                        State = $Website.state;
                                        ID = $Website.id;
                                        ApplicationPool = $Website.applicationPool;
                                        BindingInfo = $CimBindings;
					DefaultPage = $allDefaultPage
                                    }
        
        return $getTargetResourceResult;
}


# The Set-TargetResource cmdlet is used to create, delete or configuure a website on the target machine. 
function Set-TargetResource 
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    param 
    (       
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PhysicalPath,

        [ValidateSet("Started", "Stopped")]
        [string]$State = "Started",

        [string]$ApplicationPool,

        [Microsoft.Management.Infrastructure.CimInstance[]]$BindingInfo,

  	[string[]]$DefaultPage

    )
 
    $getTargetResourceResult = $null;

    if($Ensure -eq "Present")
    {
        #Remove Ensure from parameters as it is not needed to create new website
        $Result = $psboundparameters.Remove("Ensure");
        #Remove State parameter form website. Will start the website after configuration is complete
        $Result = $psboundparameters.Remove("State");

        #Remove bindings from parameters if they exist
        #Bindings will be added to site using separate cmdlet
        $Result = $psboundparameters.Remove("BindingInfo");

        #Remove default pages from parameters if they exist
        #Default Pages will be added to site using separate cmdlet
        $Result = $psboundparameters.Remove("DefaultPage");

        # Check if WebAdministration module is present for IIS cmdlets
        if(!(Get-Module -ListAvailable -Name WebAdministration))
        {
            Throw "Please ensure that WebAdministration module is installed."
        }
		
		if (!(Get-Module -Name WebAdministration -ErrorAction SilentlyContinue)) {
            # Without explicit Import-Module on 2008 R2, Get-Item "IIS:\..." sometimes returns "a drive with the name iis does not exist"
            Import-Module -Name WebAdministration -Verbose:$false
        }
        $website = Get-Item "IIS:\sites\$Name" -ErrorAction SilentlyContinue

        if($website -ne $null)
        {
            #update parameters as required

            $UpdateNotRequired = $true

            #Update Physical Path if required
            if(ValidateWebsitePath -Name $Name -PhysicalPath $PhysicalPath)
            {
                $UpdateNotRequired = $false
                Set-ItemProperty "IIS:\Sites\$Name" -Name physicalPath -Value $PhysicalPath -ErrorAction Stop

                Write-Verbose("Physical path for website $Name has been updated to $PhysicalPath");
            }

            #Update Bindings if required
            if ($BindingInfo -ne $null)
            {
                if(ValidateWebsiteBindings -Name $Name -BindingInfo $BindingInfo)
                {
                    $UpdateNotRequired = $false
                    #Update Bindings
                    UpdateBindings -Name $Name -BindingInfo $BindingInfo -ErrorAction Stop

                    Write-Verbose("Bindings for website $Name have been updated.");
                }
            }

            #Update Application Pool if required
            if(($website.applicationPool -ne $ApplicationPool) -and ($ApplicationPool -ne ""))
            {
                $UpdateNotRequired = $false
                Set-ItemProperty IIS:\Sites\$Name -Name applicationPool -Value $ApplicationPool -ErrorAction Stop

                Write-Verbose("Application Pool for website $Name has been updated to $ApplicationPool")
            }

	    #Update Default pages if required 
	    if($DefaultPage -ne $null)
            {
	    	UpdateDefaultPages -Name $Name -DefaultPage $DefaultPage 
	    }

            #Update State if required
            if($website.state -ne $State -and $State -ne "")
            {
                $UpdateNotRequired = $false
                if($State -eq "Started")
                {
                    # Ensure that there are no other websites with binding information that will conflict with this site before starting
                    $existingSites = Get-Website | Where Name -ne $Name

                    foreach($site in $existingSites)
                    {
                        $siteInfo = Get-TargetResource -Name $site.name
                            
                        foreach ($binding in $BindingInfo)
                        {
                            #Normalize empty IPAddress to "*"
                            if($binding.IPAddress -eq "" -or $binding.IPAddress -eq $null)
                            {
                                $NormalizedIPAddress = "*"
                            } 
                            else
                            {
                                $NormalizedIPAddress = $binding.IPAddress
                            }

                            if( !(EnsurePortIPHostUnique -Port $Binding.Port -IPAddress $NormalizedIPAddress -HostName $binding.HostName -BindingInfo $siteInfo.BindingInfo -UniqueInstances 1))
                            {
                                #return error & Do not start Website
                                $errorId = "WebsiteBindingConflictOnStart";
                                $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
                                $errorMessage = $($LocalizedData.WebsiteBindingConflictOnStartError) -f ${Name} 
                                $exception = New-Object System.InvalidOperationException $errorMessage 
                                $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

                                $PSCmdlet.ThrowTerminatingError($errorRecord);
                            } 
                        }
                    }

                    try
                    {

                    Start-Website -Name $Name

                    }
                    catch
                    {
                        $errorId = "WebsiteStateFailure"; 
                        $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation;
                        $errorMessage = "$($_.Exception.Message) / $($_.ScriptStackTrace)"
                        $exception = New-Object System.InvalidOperationException $errorMessage ;
                        $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

                        $PSCmdlet.ThrowTerminatingError($errorRecord);
                    }
                    
                }
                else
                {
                    try
                    {

                    Stop-Website -Name $Name

                    }
                    catch
                    {
                        $errorId = "WebsiteStateFailure"; 
                        $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation;
                        $errorMessage = "$($_.Exception.Message) / $($_.ScriptStackTrace)"
                        $exception = New-Object System.InvalidOperationException $errorMessage ;
                        $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

                        $PSCmdlet.ThrowTerminatingError($errorRecord)
                    }
                }

                Write-Verbose("State for website $Name has been updated to $State");

            }

            if($UpdateNotRequired)
            {
                Write-Verbose("Website $Name already exists and properties do not need to be udpated.");
            }
            

        }
        else #Website doesn't exist so create new one
        {
            try
            {
                $newWebsiteParams = $PSBoundParameters
                # this is a workaround for 2008 R2 - if there are no websites, a new website must be created with specific Id
                if (!(Get-Website)) {
                    $newWebsiteParams.Id = 1
                }

                $Website = New-Website @newWebsiteParams
                $Result = Stop-Website $Website.name -ErrorAction Stop
            
                #Clear default bindings if new bindings defined and are different
                if($BindingInfo -ne $null)
                {
                    if(ValidateWebsiteBindings -Name $Name -BindingInfo $BindingInfo)
                    {
                        UpdateBindings -Name $Name -BindingInfo $BindingInfo
                    }
                }

		#Add Default pages for new created website  
	        if($DefaultPage -ne $null)
            	{
	    		UpdateDefaultPages -Name $Name -DefaultPage $DefaultPage  
		}

                Write-Verbose("successfully created website $Name")
                
                #Start site if required
                if($State -eq "Started")
                {
                    #Wait 1 sec for bindings to take effect
                    #I have found that starting the website results in an error if it happens to quickly
                    Start-Sleep -s 1
                    Start-Website -Name $Name -ErrorAction Stop
                }

                Write-Verbose("successfully started website $Name")
 	 
            }
            catch
           {
                $errorId = "WebsiteCreationFailure"; 
                $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation;
                $errorMessage = "$($_.Exception.Message) / $($_.ScriptStackTrace)"
                $exception = New-Object System.InvalidOperationException $errorMessage ;
                $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null
                $PSCmdlet.ThrowTerminatingError($errorRecord);		
            }
        }    
    }
    else #Ensure is set to "Absent" so remove website 
    { 
        try
        {
            if (!(Get-Module -Name WebAdministration -ErrorAction SilentlyContinue)) {
                Import-Module -Name WebAdministration -Verbose:$false
            }
            $website = Get-Item "IIS:\sites\$Name" -ErrorAction SilentlyContinue

            if($website -ne $null)
            {
                Remove-website -name $Name
        
                Write-Verbose("Successfully removed Website $Name.")
            }
            else
            {
                Write-Verbose("Website $Name does not exist.")
            }
        }
        catch
        {
            $errorId = "WebsiteRemovalFailure"; 
            $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation;
            $errorMessage = "$($_.Exception.Message) / $($_.ScriptStackTrace)"
            $exception = New-Object System.InvalidOperationException $errorMessage ;
            $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

            $PSCmdlet.ThrowTerminatingError($errorRecord);
        }
        
    }
}


# The Test-TargetResource cmdlet is used to validate if the role or feature is in a state as expected in the instance document.
function Test-TargetResource 
{
    param 
    (       
        [ValidateSet("Present", "Absent")]
        [string]$Ensure = "Present",

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PhysicalPath,

        [ValidateSet("Started", "Stopped")]
        [string]$State = "Started",

        [string]$ApplicationPool,

        [Microsoft.Management.Infrastructure.CimInstance[]]$BindingInfo,

	[string[]]$DefaultPage
    )
 
    $DesiredConfigurationMatch = $true;

    # Check if WebAdministration module is present for IIS cmdlets
    if(!(Get-Module -ListAvailable -Name WebAdministration))
    {
        Throw "Please ensure that WebAdministration module is installed."
    }

    if (!(Get-Module -Name WebAdministration -ErrorAction SilentlyContinue)) {
        Import-Module -Name WebAdministration -Verbose:$false
    }
    $website = Get-Item "IIS:\sites\$Name" -ErrorAction SilentlyContinue

    $Stop = $true

    Do
    {
        #Check Ensure
        if(($Ensure -eq "Present" -and $website -eq $null) -or ($Ensure -eq "Absent" -and $website -ne $null))
        {
            $DesiredConfigurationMatch = $false
            Write-Verbose("The Ensure state for website $Name does not match the desired state.");
            break
        }

        # Only check properties if $website exists
        if ($website -ne $null)
        {
            #Check Physical Path property
            if(ValidateWebsitePath -Name $Name -PhysicalPath $PhysicalPath)
            {
                $DesiredConfigurationMatch = $false
                Write-Verbose("Physical Path of Website $Name does not match the desired state.");
                break
            }

            #Check State
            if($website.state -ne $State -and $State -ne $null)
                            {
            $DesiredConfigurationMatch = $false
            Write-Verbose("The state of Website $Name does not match the desired state.");
            break
        }

            #Check Application Pool property 
            if(($ApplicationPool -ne "") -and ($website.applicationPool -ne $ApplicationPool))
                            {
            $DesiredConfigurationMatch = $false
            Write-Verbose("Application Pool for Website $Name does not match the desired state.");
            break
        }

            #Check Binding properties
            if($BindingInfo -ne $null)
            {
                if(ValidateWebsiteBindings -Name $Name -BindingInfo $BindingInfo)
                {
                    $DesiredConfigurationMatch = $false
                    Write-Verbose("Bindings for website $Name do not mach the desired state.");
                    break
                }

            }
        }

   	    #Check Default Pages 
            if($DefaultPage -ne $null)
            {
		$allDefaultPage = @(Get-WebConfiguration //defaultDocument/files/*  -PSPath (Join-Path "IIS:\sites\" $Name) |%{Write-Output $_.value})

		$allDefaultPagesPresent = $true

                foreach($page in $DefaultPage )
                {
                    if(-not ($allDefaultPage  -icontains $page))
                    {   
                        $DesiredConfigurationMatch = $false
			Write-Verbose("Default Page for website $Name do not mach the desired state.");
			$allDefaultPagesPresent = $false  
			break
                    }
                }
		
 		if($allDefaultPagesPresent -eq $false)
            	{
			# This is to break out from Test 
			break 
		}
            }


        $Stop = $false
    }
    While($Stop)   

    $DesiredConfigurationMatch;
}

#region HelperFunctions
# ValidateWebsite is a helper function used to validate the results 
function ValidateWebsite 
{
    param 
    (
        [object] $Website,

        [string] $Name
    )

    # If a wildCard pattern is not supported by the website provider. 
    # Hence we restrict user to request only one website information in a single request.
    if($Website.Count-gt 1)
    {
        $errorId = "WebsiteDiscoveryFailure"; 
        $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
        $errorMessage = $($LocalizedData.WebsiteDiscoveryFailureError) -f ${Name} 
        $exception = New-Object System.InvalidOperationException $errorMessage 
        $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

        $PSCmdlet.ThrowTerminatingError($errorRecord);
    }
}

# Helper function used to validate website path
function ValidateWebsitePath
{
    param
    (
        [string] $Name,

        [string] $PhysicalPath
    )

    $PathNeedsUpdating = $false

    if((Get-ItemProperty "IIS:\Sites\$Name" -Name physicalPath) -ne $PhysicalPath)
    {
        $PathNeedsUpdating = $true
    }

    $PathNeedsUpdating

}

# Helper function used to validate website bindings
# Returns true if bindings are valid (ie. port, IPAddress & Hostname combinations are unique).

function ValidateWebsiteBindings
{
    Param
    (
        [parameter()]
        [string] 
        $Name,

        [parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $BindingInfo
    )

   
    $Valid = $true

    foreach($binding in $BindingInfo)
    {
        # First ensure that desired binding information is valid ie. No duplicate IPAddres, Port, Host name combinations. 
             
        if (!(EnsurePortIPHostUnique -Port $binding.Port -IPAddress $binding.IPAddress -HostName $Binding.Hostname -BindingInfo $BindingInfo) )
        {
            $errorId = "WebsiteBindingInputInvalidation"; 
            $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
            $errorMessage = $($LocalizedData.WebsiteBindingInputInvalidationError) -f ${Name} 
            $exception = New-Object System.InvalidOperationException $errorMessage 
            $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

            $PSCmdlet.ThrowTerminatingError($errorRecord);
        }
    }     
    
    return compareWebsiteBindings -Name $Name -BindingInfo $BindingInfo
}

function EnsurePortIPHostUnique
{
    param
    (
        [parameter()]
        [System.UInt16] 
        $Port,

        [parameter()]
        [string] 
        $IPAddress,

        [parameter()]
        [string] 
        $HostName,

        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $BindingInfo,

        [parameter()]
        $UniqueInstances = 0
    )

    foreach ($Binding in $BindingInfo)
    {
        if($binding.Port -eq $Port -and [string]$Binding.IPAddress -eq $IPAddress -and [string]$Binding.HostName -eq $HostName)
        {
            $UniqueInstances += 1
        }
    }

    if($UniqueInstances -gt 1)
    {
        return $false
    }
    else
    {
        return $true
    }
}

# Helper function used to compare website bindings of actual to desired
# Returns true if bindings need to be updated and false if not.
function compareWebsiteBindings
{
    param
    (
        [parameter()]
        [string] 
        $Name,

        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $BindingInfo
    )
    #Assume bindingsNeedUpdating
    $BindingNeedsUpdating = $false

    #check to see if actual settings have been passed in. If not get them from website
    if($ActualBindings -eq $null)
    {
        $ActualBindings = (Get-ItemProperty -Path "IIS:\Sites\$Name" -Name Bindings).Collection       
        #Format Binding information: Split BindingInfo into individual Properties (IPAddress:Port:HostName)
        $ActualBindingObjects = @()
        foreach ($ActualBinding in $ActualBindings)
        {
            $ActualBindingObjects += get-WebBindingObject -BindingInfo $ActualBinding
        }
    }
    
    #Compare Actual Binding info ($FormatActualBindingInfo) to Desired($BindingInfo)
    try
    {
        if($BindingInfo.Count -le $ActualBindingObjects.Count)
        {
            foreach($Binding in $BindingInfo)
            { 
                $ActualBinding = $ActualBindingObjects | ?{$_.Port -eq $Binding.CimInstanceProperties["Port"].Value}
                if ($ActualBinding -ne $null)
                {

                    $protocol = [string]$Binding.CimInstanceProperties["Protocol"].Value
                    if (!$protocol) {
                        $protocol = 'http'
                    }
                    if([string]$ActualBinding.Protocol -ne $protocol)
                    {
                        $BindingNeedsUpdating = $true
                        break
                    }

                    if([string]$ActualBinding.IPAddress -ne [string]$Binding.CimInstanceProperties["IPAddress"].Value)
                    {
                        # Special case where blank IPAddress is saved as "*" in the binding information.
                        if([string]$ActualBinding.IPAddress -eq "*" -AND [string]$Binding.CimInstanceProperties["IPAddress"].Value -eq "") 
                        {
                            #Do nothing
                        }
                        else
                        {
                            $BindingNeedsUpdating = $true
                            break 
                        }                       
                    }

                    if([string]$ActualBinding.HostName -ne [string]$Binding.CimInstanceProperties["HostName"].Value)
                    {
                        $BindingNeedsUpdating = $true
                        break
                    }
                    if ($Binding.CimInstanceProperties["SelfSignedCertificate"].Value) 
                    {
                        if ([string]$ActualBinding.CertificateStoreName -ine 'MY') 
                        {
                            $BindingNeedsUpdating = $true
                            break
                        }
                    } 
                    else 
                    { 
                    
                        if([string]$ActualBinding.CertificateThumbprint -ne [string]$Binding.CimInstanceProperties["CertificateThumbprint"].Value)
                        {
                            $BindingNeedsUpdating = $true
                            break
                        }
                    
                        if([string]$ActualBinding.CertificateStoreName -ne [string]$Binding.CimInstanceProperties["CertificateStoreName"].Value)
                        {
                            $BindingNeedsUpdating = $true
                            break
                        }
                    }
                }
                else 
                {
                    {
                        $BindingNeedsUpdating = $true
                        break
                    }
                }
            }
        }
        else
        {
            $BindingNeedsUpdating = $true
        }

        $BindingNeedsUpdating

    }
    catch
    {
        $errorId = "WebsiteCompareFailure"; 
        $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
        $errorMessage = "$($_.Exception.Message) / $($_.ScriptStackTrace)" 
        $exception = New-Object System.InvalidOperationException $errorMessage 
        $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

        $PSCmdlet.ThrowTerminatingError($errorRecord);
    }
}

function UpdateBindings
{
    param
    (
        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $BindingInfo
    )
    
    #Need to clear the bindings before we can create new ones
    Clear-ItemProperty IIS:\Sites\$Name -Name bindings -ErrorAction Stop

    foreach($binding in $BindingInfo)
    {
        
        $Protocol = $Binding.CimInstanceProperties["Protocol"].Value
        $IPAddress = $Binding.CimInstanceProperties["IPAddress"].Value
        $Port = $Binding.CimInstanceProperties["Port"].Value
        $HostHeader = $Binding.CimInstanceProperties["HostName"].Value
        $CertificateThumbprint = $Binding.CimInstanceProperties["CertificateThumbprint"].Value
        $CertificateStoreName = $Binding.CimInstanceProperties["CertificateStoreName"].Value
        $SelfSignedCertificate = $Binding.CimInstanceProperties["SelfSignedCertificate"].Value
                    
        $bindingParams = @{}
        $bindingParams.Add('-Name', $Name)
        $bindingParams.Add('-Port', $Port)
                    
        #Set IP Address parameter
        if($IPAddress -ne $null)
                {
                $bindingParams.Add('-IPAddress', $IPAddress)
            }
        else # Default to any/all IP Addresses
                {
                $bindingParams.Add('-IPAddress', '*')
            }

        #Set protocol parameter
        if($Protocol-ne $null)
                {
                $bindingParams.Add('-Protocol', $Protocol)
            }
        else #Default to Http
                {
                $bindingParams.Add('-Protocol', 'http')
            }

        #Set Host parameter if it exists
        if($HostHeader-ne $null){$bindingParams.Add('-HostHeader', $HostHeader)}

        try
        {
            New-WebBinding @bindingParams -ErrorAction Stop
        }
        Catch
        {
            $errorId = "WebsiteBindingUpdateFailure"; 
            $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
			$errorMessage = "$($_.Exception.Message) / $($_.ScriptStackTrace)" 
            $exception = New-Object System.InvalidOperationException $errorMessage 
            $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

            $PSCmdlet.ThrowTerminatingError($errorRecord);
        }

        try
        {
            if($CertificateThumbprint -ne $null)
            {
                $newWebBinding = get-WebBinding -name $Name -Port $Port
                $newWebBinding.AddSslCertificate($CertificateThumbprint, $CertificateStoreName)
            } elseif ($SelfSignedCertificate) {
                if (!$HostName) {
                    $dnsName = (hostname)
                } else {
                    $dnsName = $HostName
                }
                $cert = Get-ChildItem -Path 'cert:\LocalMachine\My' | Where-Object { $_.Subject -imatch "CN=$dnsName" } | Select-Object -First 1
                
                if ($cert) { 
                    Write-Verbose("Using existing certificate: $($cert.Name)")
                } else {
                    Write-Verbose("Creating new self-signed certificate for '$dnsName'")
                    $cert = New-SelfSignedCertificate -DnsName $dnsName -CertStoreLocation cert:\LocalMachine\My
                }
                $newWebBinding = get-WebBinding -name $Name -Port $Port
                $newWebBinding.AddSslCertificate($cert.Thumbprint, 'My')
            }
        }
        catch
        {
            $errorId = "WebBindingCertifcateError"; 
            $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidOperation;
            $errorMessage = "$($_.Exception.Message) / $($_.ScriptStackTrace)" 
            $exception = New-Object System.InvalidOperationException $errorMessage ;
            $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $errorId, $errorCategory, $null

            $PSCmdlet.ThrowTerminatingError($errorRecord);
        }
    }
    
}

function get-WebBindingObject
{
    Param
    (
        $BindingInfo
    )

    #First split properties by ']:'. This will get IPv6 address split from port and host name
    $Split = $BindingInfo.BindingInformation.split("[]")
    if($Split.count -gt 1)
    {
        $IPAddress = $Split.item(1)
        $Port = $split.item(2).split(":").item(1)
        $HostName = $split.item(2).split(":").item(2)
    }
    else
    {
        $SplitProps = $BindingInfo.BindingInformation.split(":")
        $IPAddress = $SplitProps.item(0)
        $Port = $SplitProps.item(1)
        $HostName = $SplitProps.item(2)
    }
       
    $WebBindingObject = New-Object PSObject -Property @{Protocol = $BindingInfo.protocol;IPAddress = $IPAddress;Port = $Port;HostName = $HostName;CertificateThumbprint = $BindingInfo.CertificateHash;CertificateStoreName = $BindingInfo.CertificateStoreName}

    return $WebBindingObject
}

# Helper function used to Update default pages of website 
function UpdateDefaultPages
{
    param
    (
        [string] $Name,

        [string[]] $DefaultPage
    )

	$allDefaultPage = @(Get-WebConfiguration //defaultDocument/files/*  -PSPath (Join-Path "IIS:\sites\" $Name) |%{Write-Output $_.value})

        foreach($page in $DefaultPage )
        {
            if(-not ($allDefaultPage  -icontains $page))
            {   
		Write-Verbose("Deafult page for website $Name has been updated to $page");
                Add-WebConfiguration //defaultDocument/files -PSPath (Join-Path "IIS:\sites\" $Name) -Value @{value = $page }
            }
        }
}

#endregion