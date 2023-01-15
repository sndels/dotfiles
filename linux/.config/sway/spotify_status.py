import dbus
import sys

# Adapted from https://bbs.archlinux.org/viewtopic.php?id=242684

try:
    session = dbus.SessionBus()
    spotify = session.get_object(
        "org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2"
    )
    properties = dbus.Interface(spotify, "org.freedesktop.DBus.Properties")
    playback_status = properties.Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus")
    print("\uf001", end="")
    if playback_status == "Playing":
        metadata = properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")
        print(f" {metadata['xesam:title']} - {metadata['xesam:artist'][0]}")
except:
    print("", end="")
