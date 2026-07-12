# GitHub Setup Guide for Xyphrion

## Step-by-Step Upload Instructions

### 1. Create GitHub Repository

1. Go to [GitHub.com](https://github.com)
2. Click the **"+"** icon (top right) → **"New repository"**
3. Repository settings:
   - **Owner**: Your username
   - **Repository name**: `XyphrionScript` (or `Xyphrion`)
   - **Description**: "Advanced Bedwars Script - Powered by Xyphrion"
   - **Visibility**: Public (so users can download it)
   - ✅ **DO NOT** initialize with README (we already have one)
   - ✅ **DO NOT** add .gitignore (we have one)
   - ✅ **DO NOT** choose a license yet (we have one)
4. Click **"Create repository"**

### 2. Upload Your Files

#### Option A: GitHub Web Interface (Easiest)

1. On your new empty repository page, click **"uploading an existing file"** link
2. Drag and drop the ENTIRE folder contents:
   - All `.lua` files
   - All `.md` files
   - `assets/` folder
   - `games/` folder
   - `guis/` folder
   - `libraries/` folder
   - `profiles/` folder
   - `.gitignore`
   - `LICENSE`
   - `loadstring`
   - `reinstall.luau`
3. Scroll down and commit:
   - Commit message: "Initial commit - Xyphrion v1.0"
4. Click **"Commit changes"**

#### Option B: Git Command Line (Advanced)

```bash
cd "c:\Users\fredr\OneDrive\Documents\CatV6-main"
git init
git add .
git commit -m "Initial commit - Xyphrion v1.0"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/XyphrionScript.git
git push -u origin main
```

### 3. Verify Upload

After uploading, check that these files are visible:
- ✅ `init.lua` (main entry point)
- ✅ `main.lua` (core script)
- ✅ `README.md` (front page)
- ✅ All folders (`assets/`, `games/`, `guis/`, `libraries/`, `profiles/`)

### 4. Update Repository References (If Needed)

**IMPORTANT**: If you didn't use exactly `XyphrionScript` as your repo name, you'll need to update URLs in these files:

#### Files to Update:
1. **init.lua** - Lines with `github.com/Xyphrion/XyphrionScript`
2. **main.lua** - Lines with `github.com/Xyphrion/XyphrionScript`
3. **loadstring** - The main URL
4. **README.md** - Installation link
5. **INSTALLATION.md** - Installation link

#### Find & Replace:
- **Old**: `github.com/Xyphrion/XyphrionScript`
- **New**: `github.com/YOUR_USERNAME/YOUR_REPO_NAME`

### 5. Test Your Script

After uploading, test the script with this loadstring:

```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/XyphrionScript/main/init.lua', true))()
```

Replace:
- `YOUR_USERNAME` with your GitHub username
- `XyphrionScript` with your actual repository name

### 6. Set Up Repository Settings (Optional)

#### A. Add Topics/Tags
1. Go to your repository
2. Click the gear icon next to "About"
3. Add topics: `roblox`, `bedwars`, `script`, `xyphrion`, `lua`

#### B. Add Repository Description
1. Same "About" section
2. Description: "Advanced Bedwars Script - Work.ink Key System"
3. Website: `https://work.ink/2JiA/d653afbe-06a3-4fc9-ba5f-674b59ebcbbd`

#### C. Enable Issues (for support)
1. Go to Settings tab
2. Find "Features" section
3. Enable "Issues"

### 7. Final Checklist

Before going public:
- ✅ Repository is PUBLIC (not private)
- ✅ All files uploaded successfully
- ✅ README.md displays correctly
- ✅ Test the loadstring in-game
- ✅ Work.ink link is correct: `https://work.ink/2JiA/d653afbe-06a3-4fc9-ba5f-674b59ebcbbd`
- ✅ No personal data in profiles folder

### 8. Share Your Script

Once uploaded, share this with users:

**Loadstring:**
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/YOUR_USERNAME/XyphrionScript/main/init.lua', true))()
```

**Get Key:**
```
https://work.ink/2JiA/d653afbe-06a3-4fc9-ba5f-674b59ebcbbd
```

---

## Important Notes

### Security
- ✅ `.gitignore` file will prevent user keys from being uploaded
- ✅ Work.ink API handles authentication securely
- ✅ No sensitive data in the repository

### Updates
To update the script later:
1. Make changes to your local files
2. Go to GitHub repository
3. Upload changed files
4. Commit with description of changes

### Repository Structure
```
XyphrionScript/
├── assets/          # UI assets
├── games/           # Game-specific code
├── guis/            # GUI themes
├── libraries/       # Core libraries + work.ink auth
├── profiles/        # Profile templates
├── init.lua         # Entry point
├── main.lua         # Main script
├── README.md        # Documentation
├── INSTALLATION.md  # User guide
└── loadstring       # Quick loadstring reference
```

---

## Troubleshooting

### "404 Not Found" when testing
- Make sure repository is **Public**
- Verify file names are correct (case-sensitive)
- Check URL is using `raw.githubusercontent.com`

### Files not uploading
- Try smaller batches (upload folders separately)
- Make sure total size < 100MB
- Check GitHub is not having issues

### Script not working after upload
- Clear cache in executor
- Test with fresh executor
- Verify all files uploaded correctly
- Check console for error messages

---

## Your Repository URL Format

After creating the repository, your URLs will be:

**Repository**: `https://github.com/YOUR_USERNAME/XyphrionScript`

**Raw Init**: `https://raw.githubusercontent.com/YOUR_USERNAME/XyphrionScript/main/init.lua`

**Clone URL**: `https://github.com/YOUR_USERNAME/XyphrionScript.git`

---

Good luck with your upload! 🚀
