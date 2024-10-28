#!/bin/sh

legacy="$(tmux -V | grep -E 'tmux (1\.|2\.[0-6])')"
shiftnum='!@#$%^&*()'
bind='bind -n'
mod='M-'

char_at () {
	# Finding the character at a given position in
	# a string in a way compatible with POSIX sh.
	echo $1 | cut -c $2
}

bind_switch () {
	# Bind keys to switch between workspaces.
	tmux $bind "$1" \
		if-shell "tmux select-window -t :$2" "" "new-window -t :$2"
}

bind_move () {
	# Bind keys to move panes between workspaces.
	if [ -z "$legacy" ]
	then
		tmux $bind "$1" \
			if-shell "tmux join-pane -t :$2" \
				"" \
				"new-window -dt :$2; join-pane -t :$2; select-pane -t top-left; kill-pane" \\\;\
			select-layout \\\;\
			select-layout -E
	else
		tmux $bind "$1" \
			if-shell "tmux new-window -dt :$2" \
				"join-pane -t :$2; select-pane -t top-left; kill-pane" \
				"send escape; join-pane -t :$2" \\\;\
			select-layout
	fi
}

# TODO: make this cleaner
bind_switch_prefix () {
	# Bind keys to switch between workspaces.
	tmux bind "$1" \
		if-shell "tmux select-window -t :$2" "" "new-window -t :$2"
}

# TODO: make this cleaner
bind_move_prefix () {
	# Bind keys to move panes between workspaces.
	if [ -z "$legacy" ]
	then
		tmux bind "$1" \
			if-shell "tmux join-pane -t :$2" \
				"" \
				"new-window -dt :$2; join-pane -t :$2; select-pane -t top-left; kill-pane" \\\;\
			select-layout \\\;\
			select-layout -E
	else
		tmux bind "$1" \
			if-shell "tmux new-window -dt :$2" \
				"join-pane -t :$2; select-pane -t top-left; kill-pane" \
				"send escape; join-pane -t :$2" \\\;\
			select-layout
	fi
}

# Switch to workspace via Alt + #.
bind_switch "${mod}1" 1
bind_switch "${mod}2" 2
bind_switch "${mod}3" 3
bind_switch "${mod}4" 4
bind_switch "${mod}5" 5
bind_switch "${mod}6" 6
bind_switch "${mod}7" 7
bind_switch "${mod}8" 8
bind_switch "${mod}9" 9

# Move pane to workspace via Alt + Shift + #.
bind_move "${mod}$(char_at $shiftnum 1)" 1
bind_move "${mod}$(char_at $shiftnum 2)" 2
bind_move "${mod}$(char_at $shiftnum 3)" 3
bind_move "${mod}$(char_at $shiftnum 4)" 4
bind_move "${mod}$(char_at $shiftnum 5)" 5
bind_move "${mod}$(char_at $shiftnum 6)" 6
bind_move "${mod}$(char_at $shiftnum 7)" 7
bind_move "${mod}$(char_at $shiftnum 8)" 8
bind_move "${mod}$(char_at $shiftnum 9)" 9

bind_switch_prefix "1" 1
bind_switch_prefix "2" 2
bind_switch_prefix "3" 3
bind_switch_prefix "4" 4
bind_switch_prefix "5" 5
bind_switch_prefix "6" 6
bind_switch_prefix "7" 7
bind_switch_prefix "8" 8
bind_switch_prefix "9" 9

bind_move_prefix "$(char_at $shiftnum 1)" 1
bind_move_prefix "$(char_at $shiftnum 2)" 2
bind_move_prefix "$(char_at $shiftnum 3)" 3
bind_move_prefix "$(char_at $shiftnum 4)" 4
bind_move_prefix "$(char_at $shiftnum 5)" 5
bind_move_prefix "$(char_at $shiftnum 6)" 6
bind_move_prefix "$(char_at $shiftnum 7)" 7
bind_move_prefix "$(char_at $shiftnum 8)" 8
bind_move_prefix "$(char_at $shiftnum 9)" 9
