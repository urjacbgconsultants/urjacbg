import os
import re
import shutil

src_dir = r"C:\Users\DeLL\OneDrive\Desktop\urja cbg\stitch_urja_cbg_consultant_website"
dest_dir = r"C:\Users\DeLL\OneDrive\Desktop\urja cbg"

pages = {
    "home_urja_cbg_consultants": "index.html",
    "about_urja_cbg_consultants": "about.html",
    "our_services_urja_cbg_consultants": "services.html",
    "free_consultation_urja_cbg_consultants": "free-consultation.html"
}

def fix_links(content):
    # This is a bit tricky, but we can do simple replacements based on text
    # Assuming standard navigation block:
    content = re.sub(r'<a([^>]*?)href="[^"]*?"([^>]*?)>Home</a>', r'<a\1href="index.html"\2>Home</a>', content)
    content = re.sub(r'<a([^>]*?)href="[^"]*?"([^>]*?)>About Us</a>', r'<a\1href="about.html"\2>About Us</a>', content)
    content = re.sub(r'<a([^>]*?)href="[^"]*?"([^>]*?)>Services</a>', r'<a\1href="services.html"\2>Services</a>', content)
    content = re.sub(r'<a([^>]*?)href="[^"]*?"([^>]*?)>Our Services</a>', r'<a\1href="services.html"\2>Our Services</a>', content)
    content = re.sub(r'<a([^>]*?)href="[^"]*?"([^>]*?)>Contact Us</a>', r'<a\1href="free-consultation.html"\2>Contact Us</a>', content)
    
    # "Get Free Consultation" link or other {{DATA:SCREEN:SCREEN_X}}
    content = re.sub(r'href="\{\{DATA:SCREEN:[^\}]+\}\}"', r'href="free-consultation.html"', content)
    
    # Also "Get a Quote" in free-consultation
    content = re.sub(r'<a([^>]*?)href="[^"]*?"([^>]*?)>Get a Quote</a>', r'<a\1href="free-consultation.html#project-inquiry-form"\2>Get a Quote</a>', content)

    return content

for folder, out_file in pages.items():
    in_path = os.path.join(src_dir, folder, "code.html")
    out_path = os.path.join(dest_dir, out_file)
    
    if os.path.exists(in_path):
        with open(in_path, 'r', encoding='utf-8') as f:
            html = f.read()
            
        html = fix_links(html)
        
        with open(out_path, 'w', encoding='utf-8') as f:
            f.write(html)
        print(f"Processed and wrote {out_file}")
    else:
        print(f"Missing {in_path}")

print("Done building website.")
