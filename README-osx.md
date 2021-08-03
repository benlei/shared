MacOS comes with mouse acceleration on. To turn it off:

    defaults write .GlobalPreferences com.apple.mouse.scaling -1


If browser is extremely slow, it may be because IPv6 resolution. Not sure why Macs have issues with IPv6, though.

    networksetup -setv6off <name of network>
    
And if you want to turn it back on:

    networksetup -setv6automatic <name of network>
