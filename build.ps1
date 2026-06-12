$srcDir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg\stitch_urja_cbg_consultant_website"
$destDir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg"

$pages = @{
    "home_urja_cbg_consultants" = "index.html"
    "about_urja_cbg_consultants" = "about.html"
    "our_services_urja_cbg_consultants" = "services.html"
    "free_consultation_urja_cbg_consultants" = "free-consultation.html"
}

foreach ($folder in $pages.Keys) {
    $inFile = Join-Path -Path $srcDir -ChildPath "$folder\code.html"
    $outFile = $pages[$folder]
    $outPath = Join-Path -Path $destDir -ChildPath $outFile
    
    if (Test-Path $inFile) {
        $content = Get-Content -Path $inFile -Raw -Encoding UTF8
        
        # Replace Links
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>Home</a>', '<a$1href="index.html"$2>Home</a>'
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>About Us</a>', '<a$1href="about.html"$2>About Us</a>'
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>Services</a>', '<a$1href="services.html"$2>Services</a>'
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>Our Services</a>', '<a$1href="services.html"$2>Our Services</a>'
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>Contact Us</a>', '<a$1href="free-consultation.html"$2>Contact Us</a>'
        
        $content = $content -replace 'href="\{\{DATA:SCREEN:[^\}]+\}\}"', 'href="free-consultation.html"'
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>Get a Quote</a>', '<a$1href="free-consultation.html#project-inquiry-form"$2>Get a Quote</a>'
        
        Set-Content -Path $outPath -Value $content -Encoding UTF8
        Write-Host "Processed and wrote $outFile"
    } else {
        Write-Host "Missing $inFile"
    }
}

Write-Host "Done building website."
