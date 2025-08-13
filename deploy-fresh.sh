#!/bin/bash

# FRESH DEPLOYMENT SCRIPT - Deploy everything from scratch
# This script completely replaces the gh-pages branch content

echo "🧹 Starting FRESH deployment from scratch..."

# Clean any existing deployment artifacts
echo "🗑️ Cleaning previous deployment artifacts..."
rm -rf deploy-temp
rm -rf .git/deploy-temp

# Build the Flutter web app fresh
echo "📦 Building Flutter web app..."
flutter build web --release --base-href /mobile-ui-playground/

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Build failed! build/web directory not found."
    exit 1
fi

echo "✅ Build completed successfully!"

# Create a completely fresh temporary directory
echo "🆕 Creating fresh deployment directory..."
mkdir deploy-temp
cd deploy-temp

# Copy ONLY the built web files (nothing else)
echo "📋 Copying built web files..."
cp -r ../build/web/* .

# Verify what we're about to deploy
echo "📋 Files to be deployed:"
ls -la

# Initialize a completely fresh git repository
echo "🔧 Initializing fresh git repository..."
git init

# Configure git
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

# Add all files
echo "📝 Adding all files to git..."
git add .

# Create initial commit
echo "💾 Creating initial commit..."
git commit -m "FRESH DEPLOYMENT: Complete rebuild from scratch - $(date)"

# Add the remote origin
echo "🔗 Adding remote origin..."
git remote add origin https://github.com/fabughali/mobile-ui-playground.git

# Force push to gh-pages branch (this will completely replace everything)
echo "🚀 Force pushing to gh-pages branch..."
git push -f origin HEAD:gh-pages

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "✅ FRESH DEPLOYMENT SUCCESSFUL!"
    echo "🎉 All files in gh-pages branch have been completely replaced"
    echo "📅 Deployment timestamp: $(date)"
    echo "🌐 Live URL: https://fabughali.github.io/mobile-ui-playground/"
else
    echo "❌ Deployment failed!"
    exit 1
fi

# Clean up
cd ..
rm -rf deploy-temp

echo "🧹 Cleanup completed"
echo "🎯 Fresh deployment from scratch is complete!"
