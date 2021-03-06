@{
    Name = 'ScriptCop'
    Screen = {
        New-ListBox -On_MouseDoubleClick { 
            if ($this.SelectedItem) {
                $file = $this.SelectedItem.ItemWithProblem.ScriptBlock.File
                $ise = [Windows.Window]::GetWindow($this).Resources.ISE
                if ($file -and $ise) {
                    $ise.CurrentPowerShellTab.Invoke("
                    `$psise.CurrentPowerShellTab.Files.Add('`$file')
                    `$psise.CurrentPowerShellTab.ExpandedScript = `$true
                    ")
                }
            }
        } -ItemTemplate {
            New-StackPanel -Orientation Horizontal -MaxWidth 640 -Children { 
                New-TextBlock -Name "ItemWithProblem" -FontWeight DemiBold
                New-TextBlock ":"
                New-TextBlock -Name "Problem" -TextWrapping Wrap 
            } | ConvertTo-DataTemplate @{
                "ItemWithProblem.Text" = "ItemWithProblem"
                "Problem.Text" = "Problem"
            }

        }
    }
    DataUpdate = {
        $sb = try {[ScriptBlock]::Create($psise.CurrentFile.Editor.Text ) } catch {} 
        if ($sb)  {
            Test-Command -ScriptBlock $sb
        }
    }
    UiUpdate = {
        $this.Content.ItemsSource=  $args
    }
    UpdateFrequency = "0:0:15"
    UpdateOnFileChange = $true

}, @{
    Name = 'ScriptCop Online'
    Site = 'http://scriptcop.start-automating.com/Test-Command'
    #Horizontal = $true
}