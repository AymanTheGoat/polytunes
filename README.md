# PolyTunes
### _The best Polybar Script, Ever_

PolyTunes is a Polybar script for controlling media playback (specifically Spotify) and displaying current song information with options to scroll metadata, such as the artist and song title.

### Features

 - Media Control: Play/pause, next, and previous song commands.
 - Song Information: Display the current song name and artist.
 - Scroll Song Info: Scroll the artist and song title with customizable display length, interval and spacing.
 - Platform: Works on Linux and any platform with D-Bus support.

As Gerard Way says :
> "Remember the first time you went to a show and saw your favorite band. You wore their shirt, and sang every word. You didn't know anything about scene politics, haircuts, or what was cool. All you knew was that this music made you feel different from anyone you shared a locker with. Someone finally understood you. This is what music is about."



### Build from source

PolyTunes requires D-Bus as it is used to communicate with Spotify media player.

Install Dartlang.
you can find more info in https://dart.dev/get-dart
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

Make the program executable.
```sh
chmod +x bin/main.exe
```
lastly rename it to rename it to polytunes and put it in polybar scripts folder. 
