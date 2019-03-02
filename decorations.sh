#!/bin/sh
# ~/.config/bspwm/decorations.sh: Script to set informative decorations

	BORDER_WIDTH=16
	GAP_WIDTH=64
	MAIN_WIDTH=304
	KEYS_WIDTH=320
	TITLEBAR_WIDTH=128
	STATUSBAR_WIDTH=128

	CONKYS_RUNNING=$(pgrep -c -x conky)
	BORDERS=$(bspc config border_width)
	GAP=$(bspc config window_gap)
	RIGHT_PADDING=$(bspc config right_padding)
	LEFT_PADDING=$(bspc config left_padding)
	TOP_PADDING=$(bspc config top_padding)
	BOTTOM_PADDING=$(bspc config bottom_padding)

	if [ "$1" = "borders" ]
	then
		case $2 in
			on)
				BORDERS=$BORDER_WIDTH
				;;
			off)
				BORDERS=0
				;;
			toggle)
				if [ $BORDERS -eq 0 ]
				then
					BORDERS=$BORDER_WIDTH
				else
					BORDERS=0
				fi
				;;
		esac
		bspc config border_width $BORDERS
	fi

	if [ "$1" = "gaps" ]
	then
		case $2 in
			on)
				GAP=$GAP_WIDTH
				;;
			off)
				GAP=0
				;;
			toggle)
				if [ $GAP -eq 0 ]
				then
					GAP=$GAP_WIDTH
				else
					GAP=0
				fi
				;;
		esac
		bspc config window_gap $GAP
		if [ $CONKYS_RUNNING -ne 0 ]
		then
			RIGHT_PADDING=$[ $MAIN_WIDTH - $GAP ]
			LEFT_PADDING=$[ $KEYS_WIDTH - $GAP ]
			TOP_PADDING=$[ $TITLEBAR_WIDTH - $GAP ]
			BOTTOM_PADDING=$[ $STATUSBAR_WIDTH - $GAP ]
			bspc config right_padding $RIGHT_PADDING
			bspc config left_padding $LEFT_PADDING
			bspc config top_padding $TOP_PADDING
			bspc config bottom_padding $BOTTOM_PADDING
		fi
	fi

	if [ "$1" = "conky" ]
	then
		killall conky
		case $2 in
			on)
				RIGHT_PADDING=$[ $MAIN_WIDTH - $GAP ]
				LEFT_PADDING=$[ $KEYS_WIDTH - $GAP ]
				TOP_PADDING=$[ $TITLEBAR_WIDTH - $GAP ]
				BOTTOM_PADDING=$[ $STATUSBAR_WIDTH - $GAP ]
				conky -a bl -c ~/.config/conky/conky.keys.conf &
				conky -a tr -c ~/.config/conky/conky.main.conf &
				conky -a bm -c ~/.config/conky/conky.statusbar.conf &
				conky -a tm -c ~/.config/conky/conky.titlebar.conf &
				;;
			off)
				RIGHT_PADDING=0
				LEFT_PADDING=0
				TOP_PADDING=0
				BOTTOM_PADDING=0
				;;
			toggle)
				if [ $CONKYS_RUNNING -eq 0 ]
				then
					RIGHT_PADDING=$[ $MAIN_WIDTH - $GAP ]
					LEFT_PADDING=$[ $KEYS_WIDTH - $GAP ]
					TOP_PADDING=$[ $TITLEBAR_WIDTH - $GAP ]
					BOTTOM_PADDING=$[ $STATUSBAR_WIDTH - $GAP ]
					conky -a bl -c ~/.config/conky/conky.keys.conf &
					conky -a tr -c ~/.config/conky/conky.main.conf &
					conky -a bm -c ~/.config/conky/conky.statusbar.conf &
					conky -a tm -c ~/.config/conky/conky.titlebar.conf &
				else
					RIGHT_PADDING=0
					LEFT_PADDING=0
					TOP_PADDING=0
					BOTTOM_PADDING=0
				fi
				;;
		esac
		bspc config right_padding $RIGHT_PADDING
		bspc config left_padding $LEFT_PADDING
		bspc config top_padding $TOP_PADDING
		bspc config bottom_padding $BOTTOM_PADDING
	fi

	if [ "$1" = "desktop" ]
	then
		bspc desktop -f \^"$2"
		case $2 in
			1)
				wal -i ~/Dropbox/MIW/Scenery/Ocean_Lightning_6000x3274.jpg
				;;
			2)
				wal -i ~/Dropbox/MIW/Scenery/Snowy_Trees_7680x4320.jpg
				;;
			3)
				wal -i ~/Dropbox/MIW/Plants/Apple_Blossoms_5184x3456.jpg
				;;
			4)
				wal -i ~/Dropbox/MIW/Plants/Marijuana_5616x3744.jpg
				;;
			5)
				wal -i ~/Dropbox/MIW/Plants/Wheat_7776x5184.jpg
				;;
			6)
				wal -i ~/Dropbox/MIW/Food/Burger_7216x5412.jpg
				;;
			7)
				wal -i ~/Dropbox/MIW/Food/Cake_Chocolate_9344x6208.jpg
				;;
			8)
				wal -i ~/Dropbox/MIW/Food/Cake_Strawberry_5120x2880.jpg
				;;
			9)
				wal -i ~/Dropbox/MIW/Food/Fruit_Basket_6000x4000.jpg
				;;
			10)
				wal -i ~/Dropbox/MIW/Food/Steak_8533x4800.jpg
				;;
		esac
		. ~/.cache/wal/colors.sh
		bspc config normal_border_color   "$color1"  # "$color1"
		bspc config active_border_color   "$color2"  # "$color2"
		bspc config focused_border_color  "$color15" # "$color15"
		bspc config presel_feedback_color "$color1"  # "$color1"
	fi

##################### EOF ####################
