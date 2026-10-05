# General
setopt INTERACTIVE_COMMENTS 	# Allow comments in

# History
setopt EXTENDED_HISTORY 		# Save timestamp and duration for each command in history
setopt INC_APPEND_HISTORY		# Write to history file immediately, not on shell exit
setopt SHARE_HISTORY 			# Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST 	# When trimming history, remove duplicates first
setopt HIST_IGNORE_DUPS 		# Don't record duplicate consecutive commands
setopt HIST_IGNORE_SPACE 		# Ignore extra spaces
setopt HIST_REDUCE_BLANKS 		# Remove extra blanks from commands before adding to history

# Completion
setopt complete_in_word 		# Allow completion in middle of word
setopt always_to_end 			# Move cursor to end of word after completion
unsetopt menu_complete 			# Don't auto-insert first match
