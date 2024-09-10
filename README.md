# PolyTunes
### _The best Polybar Script, Ever._

PolyTunes is a Polybar script for controlling Spotify player playback and displaying current song information with options to scroll metadata, such as the artist and song title.

### Features

 - Media Control: Play/pause, next, and previous song commands.
 - Song Information: Display the current song name and artist.
 - Scroll Song Info: Scroll the artist and song title with customizable display length, interval and spacing.
 - Platform: Works on Linux and any platform with D-Bus support.

As Gerard Way says :
> "Remember the first time you went to a show and saw your favorite band. You wore their shirt, and sang every word. You didn't know anything about scene politics, haircuts, or what was cool. All you knew was that this music made you feel different from anyone you shared a locker with. Someone finally understood you. This is what music is about."



### Installation
PolyTunes requires D-Bus as it is used to communicate with Spotify media player.
##### Install prebuilt executable
Download from [Release page](https://github.com/AymanTheGoat/polytunes/releases/tag/Releases)...

Make it executable...
```sh
chmod +x where/you/downloaded/polytunes
```

##### Build from source
Install Dartlang.
you can find more info in [Get dart SDK](https://dart.dev/get-dart)

Clone the repository...
```sh
git clone https://github.com/AymanTheGoat/polytunes.git
cd poly_tunes
```

Get the dependencies...
```sh
dart pub get
```

Compile the program...
```sh
dart compile exe bin/main.exe
```

Make the program executable...
```sh
chmod +x bin/main.exe
```

test it...
```sh
./bin/main.exe spotify -h
```

(optional) lastly rename it to rename it to polytunes and put it in polybar scripts folder. 
### Usage
##### Examples
Make sure to change `[polytunes path]` with your actual polytunes path.
```ini
[bar/polytunes_example]
modules-center = prev_button scroll playpause_button next_button

[module/prev_button]
type = custom/script
exec = echo "󰙣 "
click-left = [polytunes path] spotify previous

[module/scroll]
type = custom/script
tail = true
exec = [polytunes path] spotify scroll --display-length=30 --interval=1 --spacing=10

[module/next_button]
type = custom/script
exec = echo "󰙡 "
click-left = [polytunes path] spotify next

[module/playpause_button]
type = custom/script
exec = echo " 󰏥 "
click-left = [polytunes path] spotify playpause
```

Or if you prefer to click song name to toggle playback you can do something like this
```ini
[bar/polytunes_example]
modules-center = prev_button scroll next_button

[module/prev_button]
type = custom/script
exec = echo "󰙣 "
click-left = [polytunes path] spotify previous

[module/scroll]
type = custom/script
tail = true
exec = [polytunes path] spotify scroll --display-length=30 --interval=1 --spacing=10
click-left = [polytunes path] spotify playpause

[module/next_button]
type = custom/script
exec = echo "󰙡 "
click-left = [polytunes path] spotify next
```
Examples used here are using default Polybar config with separator removed, feel free to customize it to your liking.

##### Tips
 - It looks better when display-length equals spacing
 - If you want to make a separate button for play/pausing use ipc
 - Use a nerd font [_learn more about nerdfonts_](https://www.nerdfonts.com/#home)
 - Use a fallback font for launguages like Japanese, Arabic...
 - You can change Scroll format in source code in methods at line 85 to better fit your preferences
 - Use [polytunes path] -h for advanced usage
### License

MIT


