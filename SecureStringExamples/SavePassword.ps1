Function Export-Password {
<#
.SYNOPSIS
Store Passwords and keys in files

.DESCRIPTION
This function will Store excypted password and excryption key in text files.
The intention is to explain excrypting passwords in powershell. 


.PARAMETER SecureString
Password as securesting you got from Get-credential or Read-Host -AsSecureString

.PARAMETER Hash
Bytes of encryption key which is between 8 to 128

.PARAMETER FileName
File name to store the encrtypted password

.PARAMETER KeyFile
File name to store the keys used to encrypt the password.

.EXAMPLE
$storedSecPasswd = Read-Host -Prompt "Enter Password" -AsSecureString
Export-Password -SecureString $storedSecPasswd -Hash 16

Will be with default names.

.EXAMPLE
$storedSecPasswd = Read-Host -Prompt "Enter Password" -AsSecureString
Export-Password -SecureString $storedSecPasswd -Hash 32 -FileName .\Password.txt -KeyFile MyKeyFile.Key

.EXAMPLE

Export-Password -SecureString (Read-Host -Prompt "Enter Password" -AsSecureString) -Hash 32 -FileName .\Password.txt -KeyFile MyKeyFile.Key

.NOTES
General notes
#>


        [CmdletBinding()]
        Param (
        #Pass the Secure String
        [Parameter(Mandatory)]
        [System.Security.SecureString]
        $SecureString,

        # Bits information to encrypt the secureString
        [Parameter(Mandatory)]
        [ValidateSet("8","16","32","64","128")]
        [int]
        $Hash,

        # Filename to Store password
        [Parameter()]
        [string]
        $FileName= ".\MyEncrytedPassFile_$(Get-date -f "yyyyMMdd").txt",

        # Filename to Store Key
        [Parameter()]
        [string]
        $KeyFile= ".\MyKeyFile_$(Get-date -f "yyyyMMdd").key"
        )

        $key =New-Object Byte[] $Hash
        [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($key)

        $Params = @{

            SecureString = $SecureString 
            Key =  $key
        }

        ConvertFrom-SecureString @Params | Out-File $FileName

        $key | Out-File $KeyFile -Force

        if (Get-Item $FileName) 
        { Write-Host "Password saved in File $(get-Item $fileName | Select-Object -ExpandProperty Fullname)" -ForegroundColor Green}
        if ($KeyFile)
        { Write-Host "Password saved in File $(get-Item $KeyFile | Select-Object -ExpandProperty Fullname)" -ForegroundColor Green}
}

Function Import-Password {
   <#
   .SYNOPSIS
   Retrives password from text file
   
   .DESCRIPTION
   Retrives password from text file using encryption key file which were create by expore-password function
   
   .PARAMETER FileName
   Path of password file name which was created by export-password
   
   .PARAMETER KeyFile
   Path of key file which was created by export-password
   
   .EXAMPLE
   Import-Password -FileName .\Password.txt -KeyFile .\MyKeyFile.Key
   
   .NOTES
   This function is explain the concept. May be risky to use in realtime environment.
   #>
   
    
            [CmdletBinding()]
            Param (
                
            # Filename to Store password
            [Parameter(Mandatory)]
            [string]
            $FileName,
    
            # Filename to Store Key
            [Parameter(Mandatory)]
            [string]
            $KeyFile
            )
    
            $key = Get-Content $KeyFile
            $SavedPassword = Get-Content $FileName

            # Parameter Splatting
            # Binding the parameters of cmdlet String and Key
            
            $Params = @{
    
                String = $SavedPassword
                Key =  $key
            }
            
            # Splatting version: ConvertTo-SecureString @Params
            # expanded version : ConvertTo-SecureString -String $SavedPassword -Key $Key  
            $RetrivedSecString = ConvertTo-SecureString @Params 
            
            Write-Output $RetrivedSecString
}

