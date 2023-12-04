QTILE_SCRIPTS_DIR="$HOME/Docs"

access=$(grep -oP 'github-access-token=\K.*' "${QTILE_SCRIPTS_DIR}/key.conf")

echo "$access"
