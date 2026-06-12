$dir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg"
$files = Get-ChildItem -Path $dir -Filter "*.html"

$cleanContactBlock = @"
<div>
<h4 class="font-bold text-on-surface dark:text-white mb-6">Contact Info</h4>
<ul class="space-y-4 text-label-sm font-label-sm">
<li class="flex items-center gap-3 text-on-surface-variant dark:text-surface-variant">
<span class="material-symbols-outlined text-primary">call</span> +91 8543960458
</li>
<li class="flex items-center gap-3 text-on-surface-variant dark:text-surface-variant">
<span class="material-symbols-outlined text-primary">mail</span>
<a href="mailto:cbg.technical@gmail.com" class="hover:underline">cbg.technical@gmail.com</a>
</li>
<li class="flex items-start gap-3 text-on-surface-variant dark:text-surface-variant">
<span class="material-symbols-outlined text-primary">location_on</span>
<span>25, Baragaon, Near Babatapur International Airport,<br>Varanasi (U.P)</span>
</li>
</ul>
</div>
"@

$logoTag = '<a href="index.html" class="flex items-center"><img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAYy1DWIp0QZCzpYBcwTT-cKLYCSrSiI4cEeLLdjPiyUGA8yh_yQQZeyMCQSUw44ZNJj7vqhP7aRL-QLy7pVheT83JKyWre4Yt4RoVaYfgihsGRhnD1GqC_7B4IZkg1QnGN4VZj-C3FGBZb41155z_cNXrSLM36bCkWE4JSXPiXQPw3xlqMOrGZ8T5kOvdQuFHKXm6fGx0Ee3FYxE4J3BaPrKLn_Rs84mQCFezHgPuPMV27ns50rUCVI8CmS28fQ8kX0rS_3O7h3Acz" alt="Urja CBG Consultants Logo" class="h-12 w-auto object-contain"></a>'

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # 1. Replace Contact Info block in footer
    # We will look for <div> starting with <h4...>Contact Info</h4> or <h4...>Contact</h4>
    # and ends with </div> just before Newsletter or the end of footer grid.
    # This regex is tricky. Let's just do a string replacement for the specific blocks.
    
    # In index.html and about.html:
    $content = $content -replace '<div>\s*<h4[^>]*>Contact Info</h4>\s*<ul[\s\S]*?</ul>\s*</div>', $cleanContactBlock
    
    # In privacy.html, the block is:
    $content = $content -replace '<div>\s*<h4[^>]*>Contact</h4>\s*<ul[\s\S]*?</ul>\s*</div>', $cleanContactBlock
    
    # In services.html, there might be a contact block or maybe not.
    # Let's ensure they all have the clean contact block in the footer.
    
    # 2. Replace Text Logo with Image Logo
    # The pattern in index.html and about.html is:
    # <div class="text-headline-md font-headline-md font-bold text-primary dark:text-primary-fixed-dim">
    #                 URJA <span class="text-on-surface">CBG Consultants</span>
    # </div>
    $content = $content -replace '<div class="text-headline-md font-headline-md font-bold text-primary dark:text-primary-fixed-dim">\s*URJA <span class="text-on-surface[^"]*">CBG Consultants</span>\s*</div>', $logoTag
    
    # There is also one in the footer of privacy.html:
    # <div class="flex items-center gap-2 mb-6">
    # <img alt="Logo" class="h-8 w-auto"...
    # <span class="text-headline-md...
    # </div>
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Processed $($file.Name)"
}
Write-Host "Done standardizing contacts and logo."
