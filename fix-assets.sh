#!/bin/bash

# Replace all absolute image paths with the getAssetPath helper function
# This script will update all Vue files to use proper asset paths

echo "Updating asset paths in Vue files..."

# Find all Vue files and replace absolute image paths
find src -name "*.vue" -type f -exec sed -i "s|src=\"/\([^\"]*\)\.jpg\"|:src=\"getAssetPath('/\1.jpg')\"|g" {} \;
find src -name "*.vue" -type f -exec sed -i "s|src=\"/\([^\"]*\)\.png\"|:src=\"getAssetPath('/\1.png')\"|g" {} \;
find src -name "*.vue" -type f -exec sed -i "s|image: '/\([^']*\)\.jpg'|image: getAssetPath('/\1.jpg')|g" {} \;
find src -name "*.vue" -type f -exec sed -i "s|image: '/\([^']*\)\.png'|image: getAssetPath('/\1.png')|g" {} \;
find src -name "*.vue" -type f -exec sed -i "s|avatar: '/\([^']*\)\.png'|avatar: getAssetPath('/\1.png')|g" {} \;
find src -name "*.vue" -type f -exec sed -i "s|showcaseImage: '/\([^']*\)\.jpg'|showcaseImage: getAssetPath('/\1.jpg')|g" {} \;
find src -name "*.vue" -type f -exec sed -i "s|mainImage: '/\([^']*\)\.jpg'|mainImage: getAssetPath('/\1.jpg')|g" {} \;

echo "Asset path updates completed!"
