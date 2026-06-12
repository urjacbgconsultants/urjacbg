$privacyFile = "C:\Users\DeLL\OneDrive\Desktop\urja cbg\privacy.html"
$termsFile = "C:\Users\DeLL\OneDrive\Desktop\urja cbg\terms.html"

$privacyContent = Get-Content -Path $privacyFile -Raw -Encoding UTF8
$termsContent = Get-Content -Path $termsFile -Raw -Encoding UTF8

# Extract the TopNavBar from privacy.html
if ($privacyContent -match '(?is)(<!-- TopNavBar -->\s*<nav[^>]*>[\s\S]*?</nav>)') {
    $navBar = $matches[1]
    
    # Replace the empty header in terms.html with the navBar
    # Wait, terms.html has:
    # <!-- TopNavBar -->
    # <header class="bg-surface/90 backdrop-blur-md sticky top-0 z-50 border-b border-outline-variant/30">
    # </header>
    
    $termsContent = $termsContent -replace '(?is)<!-- TopNavBar -->\s*<header[^>]*>\s*</header>', $navBar
    Set-Content -Path $termsFile -Value $termsContent -Encoding UTF8
    Write-Host "Injected TopNavBar into terms.html"
} else {
    Write-Host "Could not find TopNavBar in privacy.html"
}
