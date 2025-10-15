#! /bin/sh

CONFIG_FILE=".config"

# List of configurations to enable (set to =y)
CONFIGS_TO_ENABLE=(
    "CONFIG_INIT"         # Essential: The init applet
    "CONFIG_ASH"          # Essential: The main shell binary (Almquist Shell)
    "CONFIG_SH_IS_ASH"    # Essential: Ensures /bin/sh links to ash
)

echo "--- 1. Enabling minimal features in ${CONFIG_FILE} ---"

# Loop through the list and use sed to change the line
for config in "${CONFIGS_TO_ENABLE[@]}"; do
    # Check if the line exists (usually as # CONFIG_... is not set)
    if grep -q "^# ${config} is not set" "$CONFIG_FILE"; then
        echo "Enabling: ${config}"
        # Use sed to replace the commented-out line with the enabled line
        sed -i "/^# ${config} is not set/c\\${config}=y" "$CONFIG_FILE"
    else
        echo "Warning: ${config} not found in disabled state. Assuming already set or missing."
    fi
done

echo "--- 2. Configuration complete. Running make oldconfig ---"
# After manual edits, run make oldconfig to resolve any automatic dependencies
make oldconfig