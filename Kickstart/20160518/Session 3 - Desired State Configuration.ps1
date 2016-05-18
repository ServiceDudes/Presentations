Break

# Manual Script:
Function Eval-Configuration{
    Param(
        $Folder
    )

    If(Test-Path $Folder){
        "Folder Present :-)"
    }Else{
        "No folder present!"
        New-Item -Path $Folder -ItemType Directory
    }
}

#Run Cmd:
Eval-Configuration -Folder "C:\HelloWorld"


# With DSC
Configuration DSCDemo
{
    node ("localhost")
    {

        File HelloWorld
        {
            Ensure          = "Present"
            DestinationPath = "C:\HelloWorld"
            Type            = "Directory"
        }       
    }
}

# Build MOF Document for CIM
DSCDemo -OutputPath $env:TEMP

# Run DSC Configuration
Start-DscConfiguration -Path $env:TEMP -Wait -Force -Verbose

# Check the Local Configuration Manager settings of DSC
Get-DscLocalConfigurationManager