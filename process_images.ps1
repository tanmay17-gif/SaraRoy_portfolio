Add-Type -AssemblyName System.Drawing
$source = 'C:\Users\tanmay\Downloads\editorial 4'
$dest = 'C:\Users\tanmay\Downloads\Miss.roy\Miss.roy\images'
$files = Get-ChildItem -Path $source -Filter '*.png'

foreach ($f in $files) {
    $img = [System.Drawing.Image]::FromFile($f.FullName)
    $newName = "ed4_$($f.BaseName.Replace(' ', '_'))_opt.jpg"
    $newPath = Join-Path -Path $dest -ChildPath $newName
    
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 75)
    $jpegCodecInfo = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    
    # Calculate new size (max width/height 1200)
    $maxWidth = 1200
    $maxHeight = 1200
    $ratioX = $maxWidth / $img.Width
    $ratioY = $maxHeight / $img.Height
    $ratio = [Math]::Min($ratioX, $ratioY)
    
    $newWidth = [int]($img.Width * $ratio)
    $newHeight = [int]($img.Height * $ratio)
    if ($newWidth -gt $img.Width) {
        $newWidth = $img.Width
        $newHeight = $img.Height
    }
    
    $newImg = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
    $g = [System.Drawing.Graphics]::FromImage($newImg)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($img, 0, 0, $newWidth, $newHeight)
    
    $newImg.Save($newPath, $jpegCodecInfo[0], $encoderParams)
    
    $g.Dispose()
    $newImg.Dispose()
    $img.Dispose()
    
    Write-Host "Processed: $newName"
}
