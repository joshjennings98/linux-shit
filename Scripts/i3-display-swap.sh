#!/usr/bin/env bash
# requires jq

DISPLAY_CONFIG=($(i3-msg -t get_outputs | jq -r '.[]|"\(.name):\(.current_workspace)"'))
INITIAL_WORKSPACE=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -c2-2)

for ROW in "${DISPLAY_CONFIG[@]}"
do
	IFS=':'
	read -ra CONFIG <<< "${ROW}"
	if [[ "${CONFIG[0]}" != "null" ]] && [[ "${CONFIG[1]}" =~ ^[0-9] ]]; then
		echo "Moving workspace number ${CONFIG[1]} right:"
		i3-msg -- workspace --no-auto-back-and-forth number "${CONFIG[1]}"
		i3-msg -- move workspace to output right	
	fi
done

echo "Shifting focus back to initial workspace (${INITIAL_WORKSPACE}):"
i3-msg workspace number $INITIAL_WORKSPACE
