$dir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg"
$files = Get-ChildItem -Path $dir -Filter "*.html"

$legalBlock = @"
</div>
<div>
<h4 class="font-bold text-on-surface dark:text-white mb-6">LEGAL &amp; ADMIN</h4>
<ul class="space-y-4">
<li class=""><a class="text-on-surface-variant dark:text-surface-variant hover:text-secondary dark:hover:text-secondary-fixed-dim hover:underline transition-all text-label-sm font-label-sm" href="privacy.html">Privacy Policy</a></li>
<li class=""><a class="text-on-surface-variant dark:text-surface-variant hover:text-secondary dark:hover:text-secondary-fixed-dim hover:underline transition-all text-label-sm font-label-sm" href="terms.html">Terms &amp; Conditions</a></li>
</ul>
"@

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Check if LEGAL & ADMIN is already there
    if ($content -notmatch 'LEGAL &amp; ADMIN') {
        # Find the end of Quick Links block
        $quickLinksPattern = '(<h4[^>]*>Quick Links</h4>\s*<ul[\s\S]*?</ul>\s*</div>)'
        
        if ($content -match $quickLinksPattern) {
            # Replace Quick Links block with Quick Links + Legal Block
            $replacement = "`$1`n" + $legalBlock
            $content = $content -replace $quickLinksPattern, $replacement
            
            # Update grid columns if it's md:grid-cols-4
            $content = $content -replace 'md:grid-cols-4', 'md:grid-cols-5'
            
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8
            Write-Host "Updated footer in $($file.Name)"
        } else {
            Write-Host "Could not find Quick Links in $($file.Name)"
        }
    } else {
        Write-Host "LEGAL & ADMIN already exists in $($file.Name)"
    }
}
