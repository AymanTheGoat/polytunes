// ------------------- Helper methods ---------------------- //
// Function to control Play/Pause
import 'dart:async';

import 'package:dbus/dbus.dart';

// Function to control Next
Future<void> playPause(DBusRemoteObject player) async {
  await player.callMethod(
    'org.mpris.MediaPlayer2.Player',
    'PlayPause',
    [],
  );
}

// Function to control Next
Future<void> goNext(DBusRemoteObject player) async {
  await player.callMethod('org.mpris.MediaPlayer2.Player', 'Next', []);
}

// Function to control Previous
Future<void> goPrevious(DBusRemoteObject player) async {
  await player.callMethod('org.mpris.MediaPlayer2.Player', 'Previous', []);
}

// Function to get playback status
Future<String> getPlaybackStatus(DBusRemoteObject player) async {
  final DBusValue playbackStatusValue = await player.getProperty(
    'org.mpris.MediaPlayer2.Player',
    'PlaybackStatus',
  );
  return playbackStatusValue.toNative();
}   

// Function to get song title
Future<String> getSongName(DBusRemoteObject player) async {
  final DBusValue metadata = await player.getProperty(
    'org.mpris.MediaPlayer2.Player',
    'Metadata',
  );
  final nativeMetadata = metadata.toNative();

  final artist = nativeMetadata["xesam:title"];
  return artist.toString();
}

// Function to get song title
Future<String> getArtistName(DBusRemoteObject player) async {
  final DBusValue metadata = await player.getProperty(
    'org.mpris.MediaPlayer2.Player',
    'Metadata',
  );
  final nativeMetadata = metadata.toNative();
  final artist = nativeMetadata["xesam:artist"].toString();
  String processedArtistName;
  if (artist.length > 2) {
    processedArtistName = artist.substring(1, artist.length - 1);
  } else {
    // In case the artist name is too short to be processed
    return '';
  }
  return processedArtistName;
}

// Function to continuously scroll the song metadata
void scrollMetaData(DBusRemoteObject player, {int displayLength = 10, int intervalSeconds = 1, int spacing = 10}) {
  int startIndex = 0; 
  String lastText = ''; 

  Timer.periodic(Duration(seconds: intervalSeconds), (Timer timer) async {
    final String playbackStatus = await getPlaybackStatus(player);

    if (playbackStatus == 'Playing') {
      final String artist = await getArtistName(player);
      final String songName = await getSongName(player);
      
      // This is for the case where an advertisement is playing
      // I know this is a weird way to implement it 
      // But honestly I CBA to clean it up since it works and that's all that matters 
      String unspacedText;
      if (artist == '') {
        unspacedText = songName;
      }
      else {
        unspacedText = "$artist - $songName"; // Feel free to change this format to your liking 
      }
      
      final String text = "$unspacedText${' ' * spacing}";
      final int textLength = text.length;

      if (text != lastText) {
        startIndex = 0;
        lastText = text;
      }

      // Check if text length is less than or equal to displayLength if so, don't scroll
      if (unspacedText.length <= displayLength) {
        // Print without scrolling
        print(text);
      } else {
        // Print with scrolling
        int endIndex = startIndex + displayLength;

        if (endIndex > textLength) {
          print(text.substring(startIndex) + text.substring(0, endIndex % textLength));
        } else {
          print(text.substring(startIndex, endIndex));
        }

        startIndex = (startIndex + 1) % textLength;
      }
    }
  });
}