# Useful commands for Synology NAS


| Command | Description |
| - | - |
| `sudo synogear install` | Installs some tools, specifically for `tmux`... after using, will become `root` |
| `sudo -i -u <user>` | Changes to a user... mostly to return back to original user |
| `/var/packages/DiagnosisTool/target/tool/tmux` | `tmux` isn't available to other users... so have to reference the command directly. At end of the synogear install session, `tmux` gets deleted. |
