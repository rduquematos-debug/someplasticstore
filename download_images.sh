#!/bin/bash

ASSETS_DIR="src/assets/products"
mkdir -p "$ASSETS_DIR"

# Clean up failed downloads first
echo "Cleaning up previous failed downloads..."
find "$ASSETS_DIR" -type f -size -100c -delete

# Read products.json and download each image
# jq is used to parse the json correctly
cat products.json | jq -r '.[] | "\(.name)|\(.reference)|\(.image)"' | while IFS="|" read -r name ref url; do
    # Create safe filename matching my products.js logic
    SAFE_NAME=$(echo "$name" | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
    if [ -n "$ref" ] && [ "$ref" != "N/A" ] && [ "$ref" != "---" ] && [ "$ref" != "null" ]; then
        FILENAME="prod_${ref}.jpg"
    else
        # If ref is missing, use safe name
        FILENAME="prod_${SAFE_NAME}.jpg"
    fi
    
    FILEPATH="$ASSETS_DIR/$FILENAME"
    
    # Crucial: append &w=340 to ensure the server returns an actual image
    # Note: url might already have params, so check if it has '?'
    if [[ "$url" == *"?"* ]]; then
        URL_WITH_WIDTH="${url}&w=500"
    else
        URL_WITH_WIDTH="${url}?w=500"
    fi
    
    if [ -f "$FILEPATH" ] && [ $(stat -c%s "$FILEPATH") -gt 100 ]; then
        # echo "Skipping $FILENAME, already exists and valid."
        continue
    fi
    
    echo "Downloading $FILENAME from ${URL_WITH_WIDTH}..."
    # We use -L to follow redirects and -H to set Referer
    curl -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36" -H "Referer: https://leiriplas.pt/" -o "$FILEPATH" "${URL_WITH_WIDTH}"
    
    # Double check size
    FILESIZE=$(stat -c%s "$FILEPATH" 2>/dev/null || echo 0)
    if [ "$FILESIZE" -lt 100 ]; then
        echo "   WARNING: $FILENAME downloaded but is only $FILESIZE bytes. Might be an error."
    else
        echo "   Success: $FILENAME saved ($FILESIZE bytes)."
    fi
done

echo "All re-downloads completed."
