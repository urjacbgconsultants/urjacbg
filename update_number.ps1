$dir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg"
$files = Get-ChildItem -Path $dir -Filter "*.html"

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Replace the old number with the new one
    $newContent = $content -replace "8543960458", "8887559945"
    
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "Updated number in $($file.Name)"
    }
}
Write-Host "All contact numbers updated successfully!"
