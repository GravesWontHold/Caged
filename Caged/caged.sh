#!/bin/bash

# Hide Terminal Window
osascript -e 'tell application "Terminal" to close (every window whose name contains "NicCagePrank")'

# List of Nic Cage images
images=(
    "https://deadline.com/wp-content/uploads/2023/11/nicolas-cage.jpg",
    "https://assets-prd.ignimgs.com/2022/07/13/nicolas-cage-in-con-air-1657720981366.jpg",
    "https://snworksceo.imgix.net/rce/26b94560-9203-4db4-9d67-40310ef65e60.sized-1000x1000.jpeg?w=1000",
    "https://static1.srcdn.com/wordpress/wp-content/uploads/2023/11/nicolas-cage-talking-while-the-declaration-of-independence-is-the-background-in-national-treasure-image.jpg"
)

# Pick a random one
randomImage=${images[$RANDOM % ${#images[@]}]}
wallpaperPath="$HOME/Desktop/niccage.jpg"
curl -o "$wallpaperPath" "$randomImage"

# Set as wallpaper
osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$wallpaperPath\""

# Add to Startup
launchAgentPath="$HOME/Library/LaunchAgents/com.niccage.plist"
cat <<EOF > "$launchAgentPath"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.niccage</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$HOME/Desktop/niccage.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF
launchctl load "$launchAgentPath"