$dir = "C:\Users\DeLL\OneDrive\Desktop\urja cbg"
$files = Get-ChildItem -Path $dir -Filter "*.html"

$unifiedFooter = @"
<footer class="bg-surface-container dark:bg-inverse-surface border-t border-outline-variant dark:border-outline full-width">
<div class="grid grid-cols-1 md:grid-cols-5 gap-gutter px-margin-desktop py-section-padding max-w-container-max mx-auto">
    <!-- Branding & Summary -->
    <div class="space-y-stack-md col-span-1 md:col-span-1">
        <a href="index.html" class="flex items-center">
            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAYy1DWIp0QZCzpYBcwTT-cKLYCSrSiI4cEeLLdjPiyUGA8yh_yQQZeyMCQSUw44ZNJj7vqhP7aRL-QLy7pVheT83JKyWre4Yt4RoVaYfgihsGRhnD1GqC_7B4IZkg1QnGN4VZj-C3FGBZb41155z_cNXrSLM36bCkWE4JSXPiXQPw3xlqMOrGZ8T5kOvdQuFHKXm6fGx0Ee3FYxE4J3BaPrKLn_Rs84mQCFezHgPuPMV27ns50rUCVI8CmS28fQ8kX0rS_3O7h3Acz" alt="Urja CBG Consultants Logo" class="h-12 w-auto object-contain">
        </a>
        <p class="text-body-md text-on-surface-variant dark:text-surface-variant">
            Providing industrial grade solutions for a sustainable tomorrow through innovation in biogas technology.
        </p>
    </div>

    <!-- Quick Links -->
    <div>
        <h4 class="font-bold text-on-surface dark:text-white mb-6">Quick Links</h4>
        <ul class="space-y-4">
            <li><a class="text-on-surface-variant dark:text-surface-variant hover:text-secondary hover:underline transition-all text-label-sm font-label-sm" href="about.html">About Us</a></li>
            <li><a class="text-on-surface-variant dark:text-surface-variant hover:text-secondary hover:underline transition-all text-label-sm font-label-sm" href="services.html">Our Services</a></li>
            <li><a class="text-on-surface-variant dark:text-surface-variant hover:text-secondary hover:underline transition-all text-label-sm font-label-sm" href="#">Solutions</a></li>
        </ul>
    </div>

    <!-- LEGAL & ADMIN -->
    <div>
        <h4 class="font-bold text-on-surface dark:text-white mb-6">LEGAL &amp; ADMIN</h4>
        <ul class="space-y-4">
            <li><a class="text-on-surface-variant dark:text-surface-variant hover:text-secondary hover:underline transition-all text-label-sm font-label-sm" href="privacy.html">Privacy Policy</a></li>
            <li><a class="text-on-surface-variant dark:text-surface-variant hover:text-secondary hover:underline transition-all text-label-sm font-label-sm" href="terms.html">Terms &amp; Conditions</a></li>
        </ul>
    </div>

    <!-- Contact Info -->
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

    <!-- Newsletter -->
    <div>
        <h4 class="font-bold text-on-surface dark:text-white mb-6">Newsletter</h4>
        <p class="text-label-sm text-on-surface-variant dark:text-surface-variant mb-4">Stay updated with our latest renewable energy projects.</p>
        <div class="flex gap-2">
            <input class="bg-white border-outline-variant rounded-lg flex-1 p-2 text-label-sm focus:ring-2 focus:ring-primary outline-none" placeholder="Your Email" type="email">
            <button class="bg-primary text-on-primary p-2 rounded-lg transition-transform active:scale-95">
                <span class="material-symbols-outlined">send</span>
            </button>
        </div>
    </div>
</div>
</footer>
"@

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    
    # Replace anything between <footer and </footer>
    $content = $content -replace '(?is)<footer.*?</footer>', $unifiedFooter
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Replaced footer in $($file.Name)"
}
Write-Host "Done replacing footers."
