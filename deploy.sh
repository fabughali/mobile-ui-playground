#!/bin/bash

# Clean deployment script for Flutter web app
# This script ensures only built files are deployed to gh-pages branch

echo "🚀 Starting clean deployment process..."

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

# Force push to gh-pages branch (this will overwrite everything)
echo "🚀 Deploying to gh-pages branch..."
git push origin HEAD:gh-pages --force

# Clean up
cd ..
rm -rf deploy-temp

echo "✅ Deployment completed successfully!"
echo "🌐 Your app should be available at: https://fabughali.github.io/mobile-ui-playground/"
