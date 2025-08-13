# 🚀 Mobile UI Playground - GitHub Pages Deployment Guide

This guide will walk you through deploying your Flutter web app to GitHub Pages using gh-pages deployment method.

## 📋 Prerequisites

- ✅ Flutter SDK (3.24.0 or higher)
- ✅ Git installed
- ✅ GitHub account
- ✅ Your Flutter project ready

## 🎯 Deployment Steps

### Step 1: Create GitHub Repository

1. Go to [GitHub.com](https://github.com) and sign in
2. Click the "+" icon in the top right corner
3. Select "New repository"
4. **Repository name**: `mobile-ui-playground`
5. **Description**: "Mobile UI Playground - Flutter Web App"
6. **Make it PUBLIC** (required for free GitHub Pages)
7. **DO NOT** check "Add a README file"
8. **DO NOT** check "Add .gitignore"
9. **DO NOT** check "Choose a license"
10. Click "Create repository"

### Step 2: Run the Deployment Script

```bash
# Make the script executable
chmod +x deploy.sh

# Run the deployment script
./deploy.sh
```

The script will automatically:
- Set up your repository details
- Initialize git repository
- Push code to GitHub
- Update README with correct URLs

### Step 3: Enable GitHub Pages

1. Go to your GitHub repository
2. Click **Settings** tab
3. In left sidebar, click **Pages**
4. Under **Source**, select **Deploy from a branch**
5. Select **gh-pages** branch and **/(root)** folder
6. Click **Save**

### Step 4: Monitor Deployment

1. Go to **Actions** tab
2. You'll see "Deploy Flutter Web to GitHub Pages" workflow
3. Click on it to see build progress
4. Wait for green checkmark (✅)

## 🔧 How It Works

### GitHub Actions Workflow

The `.github/workflows/deploy.yml` file:

1. **Triggers**: On every push to main branch
2. **Builds**: Flutter web app with correct base href
3. **Deploys**: Automatically to gh-pages branch
4. **Updates**: Live site on every push

### Base Href Configuration

- **Repository name**: `mobile-ui-playground`
- **Base href**: `/mobile-ui-playground/`
- **Final URL**: `https://fabughali.github.io/mobile-ui-playground/`

### File Structure

```
Repository Root/
├── .github/workflows/deploy.yml  # GitHub Actions
├── web/index.html               # Web entry point
├── lib/                         # Flutter source code
├── deploy.sh                    # Deployment script
└── README.md                    # Project documentation
```

## 🚀 Your App Will Be Available At

```
https://fabughali.github.io/mobile-ui-playground/
```

## 🔄 Continuous Deployment

- **Automatic**: Every push to main branch triggers deployment
- **No manual steps**: After initial setup
- **Real-time updates**: Changes appear live within minutes
- **Build logs**: Available in Actions tab

## 🛠️ Troubleshooting

### Common Issues

1. **App loads but assets don't display**
   - Check that base href matches repository name exactly (`/mobile-ui-playground/`)

2. **CV downloads don't work**
   - Ensure all asset files are committed and pushed

3. **App shows 404 errors**
   - Verify all files are in the main branch
   - Check Actions tab for build errors

4. **Pages not building**
   - Ensure repository is public
   - Check Actions tab for workflow errors

### Manual Build (if needed)

```bash
# Build with correct base href
flutter build web --release --base-href /mobile-ui-playground/

# Push changes
git add .
git commit -m "Manual build and deploy"
git push origin main
```

## 📚 Additional Resources

- [Flutter Web Documentation](https://flutter.dev/web)
- [GitHub Pages Documentation](https://pages.github.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🎉 Success!

Once deployed, your Flutter web app will be:
- ✅ Live on GitHub Pages at: **https://fabughali.github.io/mobile-ui-playground/**
- ✅ Automatically updated on every push
- ✅ Accessible to anyone with the URL
- ✅ Mobile-responsive and cross-platform

---

**Need help?** Check the Actions tab in your repository for detailed build logs and error messages.
