from firecrawl import FirecrawlApp

app = FirecrawlApp(api_key="fc-3cb69bf1f1bd4f7b99439b8ff4348e7d")

try:
    doc = app.scrape("https://warhol-arts.webflow.io/?utm_id=97760_v0_s00_e0_tv4")
    
    if hasattr(doc, 'markdown') and doc.markdown:
        with open("warhol_content.md", "w", encoding="utf-8") as f:
            f.write(doc.markdown)
            
    if hasattr(doc, 'html') and doc.html:
        with open("warhol_content.html", "w", encoding="utf-8") as f:
            f.write(doc.html)
            
    print("Scrape complete. Files saved.")
except Exception as e:
    print(f"Scrape failed: {e}")
