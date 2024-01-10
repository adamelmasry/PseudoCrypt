# Directory and file setup
$baseDir = [Environment]::GetFolderPath("MyDocuments")
$fileSize = 2.5 * 1048576 # 2.5MB in bytes
$encryptionPassword = "YourPasswordHere"  # chosen password

 

# Encrypt a file using a password
function Encrypt-File($path, $password) {
    $key = [System.Text.Encoding]::UTF8.GetBytes($password.PadRight(32, '0'))[0..15]
    $aes = New-Object System.Security.Cryptography.AesCryptoServiceProvider
    $aes.Key = $key
    $aes.IV = [byte[]]::new(16) # Initializing to zeros

 

    $encryptor = $aes.CreateEncryptor()
    $content = [System.IO.File]::ReadAllBytes($path)
    $encryptedBytes = $encryptor.TransformFinalBlock($content, 0, $content.Length)

 

    [System.IO.File]::WriteAllBytes("$path.encrypted", $encryptedBytes)
}

 

# Create the subfolders and generate random data files
for ($j=0; $j -lt 3; $j++) {
    $subDir = "$baseDir\randomSubFolder$($j)"
    New-Item $subDir -ItemType directory

 

    for ($i=0; $i -lt 100; $i++) {
        echo "Creating file $i in subfolder $j..."
        $out = New-Object byte[] $fileSize
        (New-Object Random).NextBytes($out)
        $filePath = "$subDir\random-file$($i).bin"
        [IO.File]::WriteAllBytes($filePath, $out)

 

        # Encrypt the file
        Encrypt-File -path $filePath -password $encryptionPassword

 

        # Delete the original file after encryption
        Remove-Item -Path $filePath
    }
}

 

# Zip the encrypted files and rename to .iso
$zipLocation = "$baseDir\AllFiles.zip"
Compress-Archive -Path "$baseDir\randomSubFolder*\*.encrypted" -DestinationPath $zipLocation
Rename-Item -Path $zipLocation -NewName "$baseDir\AllFiles.iso"

 
# Change 'user' to SFTP server username and change 'sftpServerIP' with your server's IP
$localFile = "$baseDir\AllFiles.iso"
echo "put $localFile /home/user" | sftp user@sftpServerIP