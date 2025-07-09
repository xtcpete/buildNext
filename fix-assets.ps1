# PowerShell script to fix asset paths in Vue files
Write-Host "Updating asset paths in Vue files..."

# Get all Vue files
$vueFiles = Get-ChildItem -Path "src" -Filter "*.vue" -Recurse

foreach ($file in $vueFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Replace image src attributes
    $content = $content -replace 'src="/([^"]*\.(?:jpg|png|gif|webp))"', ':src="getAssetPath(`"/$1`")"'
    
    # Replace image properties in JavaScript
    $content = $content -replace "image: '/([^']*\.(?:jpg|png|gif|webp))'", 'image: getAssetPath("/$1")'
    $content = $content -replace "avatar: '/([^']*\.(?:jpg|png|gif|webp))'", 'avatar: getAssetPath("/$1")'
    $content = $content -replace "showcaseImage: '/([^']*\.(?:jpg|png|gif|webp))'", 'showcaseImage: getAssetPath("/$1")'
    $content = $content -replace "mainImage: '/([^']*\.(?:jpg|png|gif|webp))'", 'mainImage: getAssetPath("/$1")'
    
    # Replace array elements with image paths
    $content = $content -replace "'/([^']*\.(?:jpg|png|gif|webp))'", 'getAssetPath("/$1")'
    
    Set-Content $file.FullName -Value $content
    Write-Host "Updated: $($file.Name)"
}

Write-Host "Asset path updates completed!"
