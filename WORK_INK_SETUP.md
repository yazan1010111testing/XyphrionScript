# Work.ink Key System Setup Guide

This guide will help you set up the work.ink key system for Xyphrion.

## Step 1: Create a Work.ink Account
1. Go to [work.ink](https://work.ink/)
2. Create an account or log in
3. Navigate to the dashboard

## Step 2: Create a New Link
1. Click "Create New Link" or "Add Link"
2. Set up your link with:
   - **Name**: Xyphrion Key System
   - **Destination**: Your Discord server or website
   - **Type**: Choose "Key System" or "Link Shortener with Tasks"

## Step 3: Configure Tasks
Add tasks users must complete to get their key:
- Watch video/ads
- Visit websites
- Complete surveys
- Or other monetization options

## Step 4: Get Your Link ID
After creating the link, you'll receive a **Link ID** (looks like: `abc123xyz`)

## Step 5: Update the Script
1. Open `libraries/workink_auth.lua`
2. Find line 6: `LINK_ID = "YOUR_LINK_ID_HERE"`
3. Replace `YOUR_LINK_ID_HERE` with your actual Link ID
4. Save the file

Example:
```lua
LINK_ID = "abc123xyz", -- Your actual Link ID from work.ink
```

## Step 6: Update Installation Guide
1. Open `INSTALLATION.md`
2. Find the work.ink link: `https://work.ink/YOUR_LINK_ID_HERE`
3. Replace with your actual link

## Work.ink API Integration

The authentication system uses work.ink's API to verify keys:

### Key Verification
- API Endpoint: `https://api.work.ink/api/check`
- Method: POST
- Validates user keys in real-time

### Key Storage
- Keys are saved locally: `xyphrion/profiles/key.txt`
- Automatic verification on each script load
- Invalid keys are automatically removed

## Optional: HWID Protection

To enable HWID (Hardware ID) protection:

1. Enable HWID checking in your work.ink dashboard
2. The script already includes HWID verification code
3. Each key will be locked to one device

## Testing Your Setup

1. Update the Link ID in the code
2. Push changes to your GitHub repository
3. Run the script in-game
4. You should see the key prompt with your work.ink link
5. Complete the tasks and get a test key
6. Verify the key works correctly

## Troubleshooting

### Users Can't Get Keys
- Check if your work.ink link is active
- Verify tasks are properly configured
- Make sure the link ID is correct in the code

### Keys Not Working
- Verify API endpoint is correct
- Check internet connection
- Ensure work.ink API is operational

### Script Errors
- Check console for error messages
- Verify all API calls use proper syntax
- Test with a valid key first

## Monetization Tips

### Task Configuration
- Balance between user experience and revenue
- Don't make tasks too difficult
- Test the process yourself first

### Key Duration
- Set appropriate expiry times in work.ink
- Consider offering lifetime keys for supporters
- Option for renewable keys

### Support
- Provide clear instructions to users
- Have a Discord channel for key issues
- Monitor work.ink dashboard regularly

## Additional Features

### Custom Verification Messages
Edit `libraries/workink_auth.lua` to customize:
- Error messages
- Success notifications
- Key prompts

### Whitelist System
The code includes a whitelist check function for premium users:
```lua
WorkInkAuth:CheckWhitelist(key)
```

Enable this for special users who should bypass the key system.

## Security Notes

⚠️ **Important Security Considerations:**

1. **Never** commit your actual Link ID to public repositories
2. Keep your work.ink dashboard credentials secure
3. Monitor for key sharing/leaking
4. Regularly rotate keys if needed
5. Consider HWID locking for premium features

## Support

For work.ink specific issues:
- Visit: https://work.ink/support
- Check their documentation
- Contact their support team

For script issues:
- Join Discord: discord.gg/xyphrion
- Create GitHub issue
- Check troubleshooting guide

---

## Quick Reference

**Your Link ID Location**: `libraries/workink_auth.lua` - Line 6

**User Key Link Format**: `https://work.ink/YOUR_LINK_ID`

**Key Storage**: `xyphrion/profiles/key.txt`

**API Endpoint**: `https://api.work.ink/api/`

---

Last Updated: 2026-07-12
