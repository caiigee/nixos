#!/usr/bin/env bash

# Set default values if variables are not set
PROJECTS_DIR="${PROJECTS_DIR:-$HOME/Desktop/Projects}"
IDE="${IDE:-$EDITOR}"

# Function to determine the main language of a project
get_project_icon() {
    local folder="$1"
    if [[ -f "$folder/Cargo.toml" ]]; then
        echo "🦀"  # Rust
    elif [[ -f "$folder/package.json" ]]; then
        echo "📦"  # JavaScript/Node.js
    elif [[ -f "$folder/pyproject.toml" || -f "$folder/requirements.txt" ]]; then
        echo "🐍"  # Python
    elif [[ -f "$folder/go.mod" ]]; then
        echo "🐹"  # Go
    elif [[ -f "$folder/CMakeLists.txt" ]]; then
        echo "⚙️"  # CMake/C++
    else
        echo "📁"  # Default folder icon
    fi
}

# Get the list of project folders
projects=()
while IFS= read -r -d '' folder; do
    projects+=("$(get_project_icon "$folder") $(basename "$folder")")
done < <(find "$PROJECTS_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

# Ensure we have projects to choose from
if [[ ${#projects[@]} -eq 0 ]]; then
    echo "No projects found in $PROJECTS_DIR"
    exit 1
fi

# Use fzf to select a project
chosen=$(printf "%s\n" "${projects[@]}" | fzf --prompt="Select a project: ")

# Extract project name
chosen_dir=$(echo "$chosen" | cut -d ' ' -f2-)

# If no project was selected, exit
if [[ -z "$chosen_dir" ]]; then
    echo "No project selected."
    exit 1
fi

# Open the project in the terminal
cd "$PROJECTS_DIR/$chosen_dir" || exit
exec tmux new nix develop -c "$EDITOR"
