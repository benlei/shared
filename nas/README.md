# Useful commands for Synology NAS


| Command | Description |
| - | - |
| `sudo synogear install` | Installs some tools, specifically for `tmux`... after using, will become `root` |
| `sudo -i -u <user>` | Changes to a user... mostly to return back to original user |
| `/var/packages/DiagnosisTool/target/tool/tmux` | `tmux` isn't available to other users... so have to reference the command directly. At end of the synogear install session, `tmux` gets deleted. |

# Useful self-hosted containers

| Container | Website | Purpose |
| - | - | - |
| `nbr23/youtube-dl-server` | [Link](https://github.com/nbr23/youtube-dl-server) | |
| ⚠️ `containrrr/watchtower` | [Link](https://containrrr.dev/watchtower/) | Keeps containers up to date.<br/><br/>But you'd be giving it your docker socket / god powers... is it worth the risk? Can pin the version |
