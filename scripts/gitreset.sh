#!/bin/sh

# Usage:

# ./gitreset.sh
# - Reset all commits

# ./gitreset.sh "init"
# - Reset all commits with a new initial commit message

# ./gitreset.sh 2
# - Remove the last N commits

# ./gitreset.sh res 2
# - Restore the last N removed commits

set -e  # exit on any error

if [[ "$1" == "res" ]]; then
  N=${2:-1}
  echo "♻️  Restoring last $N deleted commits..."

  if [[ $N -le 0 ]]; then
    echo "❌ Invalid number of commits: $N"
    exit 1
  fi

  # Restore HEAD to where it was before the reset
  git reset --hard "HEAD@{${N}}"
  git push -f origin HEAD
  echo "✅ Restored $N commit(s) that were previously deleted."
  exit 0
fi

if [[ "$1" =~ ^[0-9]+$ ]]; then
  N=$1
  echo "⚙️  Removing last $N commits (they can be restored later)..."

  if [[ $N -le 0 ]]; then
    echo "❌ Invalid number of commits: $N"
    exit 1
  fi

  # Delete N commits but keep them in reflog
  git reset --hard HEAD~$N
  git push -f origin HEAD
  echo "✅ Done! Last $N commits deleted."
  echo "💡 You can restore them using: ./gitreset.sh res $N"
  exit 0
fi

# Otherwise, perform a full reset (fresh orphan commit)
COMMIT_MSG=${1:-"Initial commit"}

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
  echo "❌ Not a git repository. cd into the repo first."
  exit 1
}

echo "🚨 WARNING: This will rewrite main history and force-push."
echo "Commit message will be: \"$COMMIT_MSG\""
read -r -p "Type CONFIRM to proceed: " ack
if [ "$ack" != "CONFIRM" ]; then
  echo "✅ Aborted. Nothing changed."
  exit 1
fi

echo "Creating orphan branch..."
git checkout --orphan latest_branch

echo "Adding files..."
git add -A

echo "Committing changes..."
git commit -m "$COMMIT_MSG"

echo "Deleting old main branch..."
git branch -D main || true  # ignore if main doesn’t exist

echo "Renaming orphan branch to main..."
git branch -m main

echo "Force pushing to remote..."
git push -f origin main

echo "✅ Done! Main branch has been fully reset."

