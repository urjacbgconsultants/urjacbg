$srcDir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg\stitch_urja_cbg_consultant_website"
$destDir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg"

$pages = @{
    "home_urja_cbg_consultants" = "index.html"
    "about_urja_cbg_consultants" = "about.html"
    "our_services_urja_cbg_consultants" = "services.html"
    "free_consultation_urja_cbg_consultants" = "free-consultation.html"
    "privacy_policy_urja_cbg_consultants" = "privacy.html"
    "terms_conditions_urja_cbg_consultants" = "terms.html"
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
        
        # Add replacements for privacy policy and terms
        $content = $content -replace 'href="\{\{DATA:SCREEN:privacy_policy_page\}\}"', 'href="privacy.html"'
        $content = $content -replace 'href="\{\{DATA:SCREEN:terms_conditions_page\}\}"', 'href="terms.html"'
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>Privacy Policy</a>', '<a$1href="privacy.html"$2>Privacy Policy</a>'
        $content = $content -replace '<a([^>]*?)href="[^"]*?"([^>]*?)>Terms &amp; Conditions</a>', '<a$1href="terms.html"$2>Terms &amp; Conditions</a>'

        # Fix HTML tags
        $content = $content -replace '<html[^>]*style="[^"]*overflow:\s*hidden[^"]*"[^>]*>', '<html class="light" lang="en">'
        $content = $content -replace '<html class="light" lang="en" style="[^"]*">', '<html class="light" lang="en">'
        $content = $content -replace '<html class="scroll-smooth" lang="en" style="[^"]*">', '<html class="scroll-smooth" lang="en">'
        
        # Clean up <section> classes: remove opacity-100 translate-y-0 opacity-0 translate-y-10
        $content = $content -replace 'opacity-100\s+', ''
        $content = $content -replace 'translate-y-0\s+', ''
        $content = $content -replace 'opacity-0\s+', ''
        $content = $content -replace 'translate-y-10\s+', ''
        
        $content = $content -replace 'opacity-100"', '"'
        $content = $content -replace 'translate-y-0"', '"'
        $content = $content -replace 'opacity-0"', '"'
        $content = $content -replace 'translate-y-10"', '"'
        
        $jsFind = "section.classList.add('transition-all', 'duration-700', 'opacity-0', 'translate-y-10');"
        $jsReplace = "section.classList.remove('opacity-100', 'translate-y-0');`n            section.classList.add('transition-all', 'duration-700', 'opacity-0', 'translate-y-10');"
        $content = $content.Replace($jsFind, $jsReplace)

        Set-Content -Path $outPath -Value $content -Encoding UTF8
        Write-Host "Processed and wrote $outFile"
    } else {
        Write-Host "Missing $inFile"
    }
}

Write-Host "Done building website."
