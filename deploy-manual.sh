#!/bin/bash

# Manual deployment script for Flutter web app
# This script handles cases where gh-pages branch might be protected

echo "🚀 Starting manual deployment process..."

# Build the Flutter web app
echo "📦 Building Flutter web app..."
flutter build web --release --base-href /mobile-ui-playground/

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Build failed! build/web directory not found."
    exit 1
fi

echo "✅ Build completed successfully!"

# Create a temporary directory for deployment
echo "🧹 Preparing clean deployment..."
rm -rf deploy-temp
mkdir deploy-temp

# Copy only the built web files
cp -r build/web/* deploy-temp/

# Navigate to temp directory
cd deploy-temp

# Initialize git repository
git init
git add .
git commit -m "Deploy Flutter web app - $(date)"

# Add remote origin
git remote add origin https://github.com/fabughali/mobile-ui-playground.git

# Try to force push to gh-pages branch
echo "🚀 Attempting to deploy to gh-pages branch..."
if git push origin HEAD:gh-pages --force; then
    echo "✅ Force push successful!"
else
    echo "⚠️ Force push failed, trying alternative approach..."
    
    # Try to create a new branch and then switch GitHub Pages to it
    echo "🔄 Creating new deployment branch..."
    git push origin HEAD:deploy-temp --force
    
    echo ""
    echo "📋 Manual steps required:"
    echo "1. Go to your repository: https://github.com/fabughali/mobile-ui-playground"
    echo "2. Go to Settings → Pages"
    echo "3. Change source from 'gh-pages' to 'deploy-temp'"
    echo "4. Save the changes"
    echo "5. Once confirmed working, you can delete the old gh-pages branch"
    echo ""
    echo "🌐 Your app should be available at: https://fabughali.github.io/mobile-ui-playground/"
fi

# Clean up
cd ..
rm -rf deploy-temp

echo "✅ Deployment process completed!"
