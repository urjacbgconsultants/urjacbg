$destDir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg"

$files = @("index.html", "about.html", "services.html", "free-consultation.html")

foreach ($file in $files) {
    $path = Join-Path -Path $destDir -ChildPath $file
    if (Test-Path $path) {
        $content = Get-Content -Path $path -Raw -Encoding UTF8
        
        # Remove hardcoded fixed height and overflow from html tag
        $content = $content -replace '<html[^>]*style="[^"]*overflow:\s*hidden[^"]*"[^>]*>', '<html class="light" lang="en">'
        
        # Also remove if it just has style="..."
        $content = $content -replace '<html class="light" lang="en" style="[^"]*">', '<html class="light" lang="en">'
        $content = $content -replace '<html class="scroll-smooth" lang="en" style="[^"]*">', '<html class="scroll-smooth" lang="en">'
        
        # Clean up <section> classes: remove opacity-100 translate-y-0 opacity-0 translate-y-10
        $content = $content -replace 'opacity-100\s+', ''
        $content = $content -replace 'translate-y-0\s+', ''
        $content = $content -replace 'opacity-0\s+', ''
        $content = $content -replace 'translate-y-10\s+', ''
        
        # Just in case they are at the end of the class string
        $content = $content -replace 'opacity-100"', '"'
        $content = $content -replace 'translate-y-0"', '"'
        $content = $content -replace 'opacity-0"', '"'
        $content = $content -replace 'translate-y-10"', '"'
        
        # Also update the JS to remove opacity-100 before adding opacity-0 initially
        # Find the line: section.classList.add('transition-all', 'duration-700', 'opacity-0', 'translate-y-10');
        # and insert removal
        $jsFind = "section.classList.add('transition-all', 'duration-700', 'opacity-0', 'translate-y-10');"
        $jsReplace = "section.classList.remove('opacity-100', 'translate-y-0');`n            section.classList.add('transition-all', 'duration-700', 'opacity-0', 'translate-y-10');"
        $content = $content.Replace($jsFind, $jsReplace)

        Set-Content -Path $path -Value $content -Encoding UTF8
        Write-Host "Fixed sections and html tag in $file"
    }
}
Write-Host "All files fixed."
