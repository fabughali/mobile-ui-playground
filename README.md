# Mobile UI Playground

A Mobile UI Playground with natural language commands, CRM integration, and Pieces integration built with Flutter.

## 🚀 Live Demo

**[Test the App Here](https://fabughali.github.io/mobile-ui-playground/)**

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (3.24.0 or higher)
- Git
- GitHub account

### 1. Clone and Setup Repository

```bash
# Clone the repository
git clone https://github.com/fabughali/mobile-ui-playground.git
cd mobile-ui-playground

# Install dependencies
flutter pub get

# Run locally
flutter run -d chrome
```

### 2. Deploy to GitHub Pages

This repository is configured with GitHub Actions for automatic deployment. Follow these steps:

#### Step 1: Create GitHub Repository
1. Go to [GitHub](https://github.com) and create a new repository
2. **Repository name**: `mobile-ui-playground`
3. **Important**: Make sure the repository is **public** (required for GitHub Pages)
4. Don't initialize with README, .gitignore, or license (we already have these)

#### Step 2: Run the Deployment Script
```bash
# Make the script executable
chmod +x deploy.sh

# Run the deployment script
./deploy.sh
```

The script will:
- Initialize git repository
- Set up remote origin
- Push your code to GitHub
- Update README with correct URLs

#### Step 3: Enable GitHub Pages
1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under **Source**, select **Deploy from a branch**
4. Select **gh-pages** branch and **/(root)** folder
5. Click **Save**

#### Step 4: Enable GitHub Actions
1. Go to **Actions** tab in your repository
2. Click **I understand my workflows, go ahead and enable them**
3. The deployment will start automatically

### 3. Manual Deployment (Alternative)

If you prefer to deploy manually:

```bash
# Build the web app
flutter build web --release --base-href /mobile-ui-playground/

# Push to GitHub
git add .
git commit -m "Build and deploy web app"
git push origin main
```

## 🔧 Development

### Build for Web
```bash
flutter build web --release
```

### Run Tests
```bash
flutter test
```

### Generate Code
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📱 Features

- Natural language command processing
- CRM integration capabilities
- Pieces integration
- Responsive mobile-first design
- Cross-platform compatibility

## 🏗️ Architecture

- **State Management**: Riverpod with AsyncNotifierProvider
- **UI Framework**: Flutter with Material 3 design
- **Code Generation**: build_runner for Riverpod code generation
- **Deployment**: GitHub Actions + GitHub Pages (gh-pages branch)

## 📁 Project Structure

```
lib/
├── core/           # Core utilities, theme, constants
├── features/       # Feature-specific modules
├── shared/         # Shared widgets, utils, extensions
└── main.dart       # App entry point
```

## 🚀 Deployment Status

![Deploy to GitHub Pages](https://github.com/fabughali/mobile-ui-playground/workflows/Deploy%20Flutter%20Web%20to%20GitHub%20Pages/badge.svg)

## 📝 License

This project is licensed under the MIT License.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 🔄 Automatic Deployment

This project uses GitHub Actions for continuous deployment:

1. **On every push to main branch**, the workflow automatically:
   - Sets up Flutter environment
   - Installs dependencies
   - Builds the web app with correct base href (`/mobile-ui-playground/`)
   - Deploys to gh-pages branch

2. **No manual intervention required** after initial setup

3. **Base href is automatically configured** for your repository

4. **Deployment status** is visible in the Actions tab

## 🌐 Live URL

Your app is deployed at: **https://fabughali.github.io/mobile-ui-playground/**
