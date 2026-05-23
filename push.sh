#!/bin/bash

# Get current date and time for the message
current_date=$(date "+%Y-%m-%d %H:%M")

echo "Staging files..."
git add .

echo "Committing changes..."
git commit -m "Auto-update: $current_date"

echo "Pushing to GitHub..."
git push

echo "Done! Your code is live on GitHub."
read -p "Press Enter to close..."
