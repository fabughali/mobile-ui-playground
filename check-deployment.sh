#!/bin/bash

echo "🔍 Checking deployment status..."

echo "📋 Current branch: $(git branch --show-current)"
echo "📋 Remote branches:"
git branch -r

echo ""
echo "📋 GitHub Actions status:"
echo "Visit: https://github.com/fabughali/mobile-ui-playground/actions"

echo ""
echo "📋 GitHub Pages status:"
echo "Visit: https://github.com/fabughali/mobile-ui-playground/settings/pages"

echo ""
echo "📋 Live app URL:"
echo "https://fabughali.github.io/mobile-ui-playground/"

echo ""
echo "📋 Checking gh-pages branch content..."
if git show origin/gh-pages:index.html > /dev/null 2>&1; then
    echo "✅ gh-pages branch exists and contains index.html"
    echo "📄 Files in gh-pages branch:"
    git ls-tree -r --name-only origin/gh-pages | head -20
else
    echo "❌ gh-pages branch not accessible or empty"
fi
