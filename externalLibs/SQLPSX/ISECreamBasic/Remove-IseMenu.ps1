function Remove-IseMenu ()
{
    param(
        #The name of the menu to remove 
        [Parameter(Mandatory=$true)]
        [String]$Name,
        $tabindex
    )
    if ($tabindex)
    {
        $submenu = $psise.PowerShellTabs[$tabindex].AddOnsMenu.Submenus
    }
    else
    {
        $submenu = $psise.CurrentPowerShellTab.AddOnsMenu.Submenus
    }

    if ($submenu) {
        for ($i = 0; $i -lt $submenu.count; $i++)
        {
        #    $Submenu[$i].DisplayName
            
            if ($Submenu[$i].DisplayName -eq $Name)
            {
                    $null = $submenu.remove($Submenu[$i])
                    return
            }
        }
    }
}

