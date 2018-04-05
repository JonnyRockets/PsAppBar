#########################################################################
# Author:  Kevin RAHETILAHY                                             #   
# Blog: dev4sys.blogspot.fr                                             #
#########################################################################

#########################################################################
#                        Add shared_assemblies                          #
#########################################################################

[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\System.Windows.Interactivity.dll') | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')      | out-null  
[System.Reflection.Assembly]::LoadFrom('assembly\WpfAppBar.dll')      | out-null  

#########################################################################
#                        Load Main Panel                                #
#########################################################################

$Global:pathPanel= split-path -parent $MyInvocation.MyCommand.Definition
function LoadXaml ($filename){
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}
$XamlMainWindow=LoadXaml($pathPanel+"\Main.xaml")
$reader = (New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form = [Windows.Markup.XamlReader]::Load($reader)


#########################################################################
#                   Initialize default control                          #
#########################################################################

$Explorerbtn = $Form.findName("Explorerbtn")
$ConfigPanelBtn = $Form.findName("ConfigPanelBtn")
$CloseBtn = $Form.findName("CloseBtn")

#########################################################################
#                        Event                                          #
#########################################################################

$ConfigPanelBtn.add_Click({
    #control.exe
    $topScreen = [WpfAppBar.ABEdge]::Top
    [WpfAppBar.AppBarFunctions]::SetAppBar($Form, $topScreen)
})

$Explorerbtn.add_Click({
    #explorer.exe
    $toNothing = [WpfAppBar.ABEdge]::None
    [WpfAppBar.AppBarFunctions]::SetAppBar($Form, $toNothing)

})

$CloseBtn.add_Click({
    $Form.close()
})

#########################################################################
#                        Show Dialog                                    #
#########################################################################



# align to top screen 
$Form.Left = ([System.Windows.SystemParameters]::PrimaryScreenWidth - $Form.Width)/2
$Form.ShowDialog() | Out-Null
  
