#!/run/current-system/sw/bin/bash
REPO="$1"

BORG_RELOCATED_REPO_ACCESS_IS_OK=yes \
				BORG_PASSPHRASE="$2"       \
				/run/current-system/sw/bin/borg create   \
				--filter AME                        \
				--stats                             \
				--json                              \
				--show-rc                           \
				--progress                          \
				--compression lz4                   \
				--exclude-caches                    \
				--exclude '/home/*/.cache/*'        \
				--exclude '*.ova'                   \
				--exclude 'VirtualBox VMs'          \
				$REPO::'{hostname}-{now:%Y-%m-%d.%H:%M:%S}' \
				$HOME
