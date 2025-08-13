#!/bin/bash

# Flutter Web App Deployment Script
# This script helps you deploy your Flutter app to GitHub Pages

echo "🚀 Flutter Web App Deployment Script"
echo "====================================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

echo "✅ Flutter and Git are installed"

# Set repository details for mobile-ui-playground
GITHUB_USERNAME="fabughali"
REPO_NAME="mobile-ui-playground"

echo ""
echo "📋 Repository Details:"
echo "Username: $GITHUB_USERNAME"
echo "Repository: $REPO_NAME"
echo "Live URL: https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
echo ""

# Confirm repository exists
read -p "Have you created the GitHub repository '$REPO_NAME'? (y/n): " REPO_CREATED

if [ "$REPO_CREATED" != "y" ] && [ "$REPO_CREATED" != "Y" ]; then
    echo ""
    echo "📝 Please create the repository first:"
    echo "1. Go to https://github.com/new"
    echo "2. Repository name: $REPO_NAME"
    echo "3. Make it PUBLIC (required for GitHub Pages)"
    echo "4. Don't initialize with README, .gitignore, or license"
    echo "5. Click 'Create repository'"
    echo ""
    read -p "Press Enter when you've created the repository..."
fi

# Initialize git repository if not already done
if [ ! -d ".git" ]; then
    echo ""
    echo "🔧 Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit: Mobile UI Playground Flutter web app"
fi

# Setup git and push
echo ""
echo "📤 Setting up Git and pushing to GitHub..."

# Add remote origin (remove if already exists)
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git

# Add all files
git add .

# Commit
git commit -m "Setup Flutter web app with GitHub Actions deployment"

# Push to main branch
git push -u origin main

if [ $? -ne 0 ]; then
    echo "❌ Push failed. Please check your GitHub credentials and try again."
    exit 1
fi

echo "✅ Code pushed to GitHub successfully"

# Update README with correct URLs
echo ""
echo "📝 Updating README with correct URLs..."
sed -i "s/YOUR_USERNAME/$GITHUB_USERNAME/g" README.md
sed -i "s/YOUR_REPO_NAME/$REPO_NAME/g" README.md

# Commit and push README update
git add README.md
git commit -m "Update README with correct deployment URLs"
git push

echo ""
echo "🎉 Deployment Setup Complete!"
echo "============================="
echo ""
echo "📱 Your app will be available at:"
echo "   https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
echo ""
echo "⚙️ Next steps:"
echo "1. Go to your repository: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "2. Go to Settings → Pages"
echo "3. Under 'Source', select 'Deploy from a branch'"
echo "4. Choose 'gh-pages' branch and '/(root)' folder"
echo "5. Click Save"
echo "6. Go to Actions tab and enable workflows"
echo ""
echo "🔄 The GitHub Actions workflow will:"
echo "   - Build your Flutter web app"
echo "   - Deploy it to gh-pages branch"
echo "   - Update the live site on every push"
echo ""
echo "📚 For more help, check the README.md file"
echo ""
echo "🚀 Your app is now configured for automatic deployment!"
