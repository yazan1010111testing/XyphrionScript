# Xyphrion Installation Guide

## Getting Started

### Step 1: Get Your Key
1. Visit the key system: **https://work.ink/2JiA/d653afbe-06a3-4fc9-ba5f-674b59ebcbbd**
2. Complete the tasks to get your key
3. Copy your key

### Step 2: Execute the Script

#### Option 1: Direct Loadstring (Recommended)
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Xyphrion/XyphrionScript/main/init.lua', true))()
```

#### Option 2: With Configuration
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Xyphrion/XyphrionScript/main/init.lua', true))({
    Closet = false  -- Set to true for minimal UI
})
```

### Step 3: Authentication
- On first run, you'll be prompted with a key link
- Get your key from the link provided
- The key will be saved automatically for future use

## Features
- ✅ Work.ink Key System Integration
- ✅ Advanced combat modules
- ✅ Utility features
- ✅ Multiple GUI themes (New, Old, Rise)
- ✅ Profile system with autosave
- ✅ Game-specific optimizations
- ✅ Rainbow themes and customization

## GUI Keybind
- Default keybind: **Right Shift**
- Can be changed in GUI settings

## Supported Games
The script includes optimized configurations for multiple Bedwars game IDs:
- Bedwars (6872274481)
- And many more - check the `games/` folder

## Discord Support
Join our Discord community: **discord.gg/xyphrion**

## Troubleshooting

### Key Not Working?
1. Make sure you completed all tasks on the key page
2. Copy the key exactly as shown (no extra spaces)
3. If issues persist, delete the key file at `xyphrion/profiles/key.txt` and get a new key

### Script Won't Load?
1. Make sure your executor supports the required functions (`request`, `writefile`, `readfile`)
2. Check if the GitHub repository is accessible
3. Verify your internet connection

### GUI Not Showing?
- Press the keybind (Right Shift by default)
- Check if notifications are enabled
- Rejoin the game

### Assets Not Loading?
The script will automatically download required assets on first run. Be patient during initial load (5-10 seconds).

### Need to Reset?
Run the reinstall script:
```lua
loadstring(game:HttpGet('https://raw.githubusercontent.com/Xyphrion/XyphrionScript/main/reinstall.luau'))()
```

## File Structure
```
xyphrion/
├── assets/      # UI assets and images
├── games/       # Game-specific modules
├── guis/        # GUI themes (new, old, rise)
├── libraries/   # Core libraries + work.ink auth
└── profiles/    # User profiles, settings, and saved keys
```

## Key Features Explained

### Work.ink Authentication
- Secure key system integration
- Keys are saved locally for convenience
- Automatic verification on script load
- HWID protection available

### Profile System
- Multiple profile support
- Auto-save every 10 seconds
- Per-game configurations
- Easy profile switching

### GUI Themes
- **New**: Modern clean interface
- **Old**: Classic layout
- **Rise**: Premium look inspired by Rise client

## Notes
- ✅ First run will download required files
- ✅ Settings are saved automatically
- ✅ Profile system allows multiple configurations
- ✅ Updates are fetched automatically from GitHub
- ✅ Keys are verified on each script load

## Configuration for Developers

If you're setting up your own fork, the work.ink Link ID is configured in:
`libraries/workink_auth.lua` - Line 6: `LINK_ID = "2JiA/d653afbe-06a3-4fc9-ba5f-674b59ebcbbd"`

---
For more information or support, visit our Discord: **discord.gg/xyphrion**
