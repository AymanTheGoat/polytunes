import 'dart:async';
import 'package:args/command_runner.dart';
import 'package:dbus/dbus.dart';
import 'package:polytunes/methods.dart';

// Main function that sets up the CommandRunner
Future<void> main(List<String> args) async {
  final DBusClient client = DBusClient.session();
  final DBusRemoteObject player = DBusRemoteObject(
    client,
    name: 'org.mpris.MediaPlayer2.spotify',
    path: DBusObjectPath('/org/mpris/MediaPlayer2'),
  );

  final runner = CommandRunner('spotify', 'Control media playback.')
    ..addCommand(MediaControlCommands(player));

  try {
    await runner.run(args);
  } catch (e) {
    print('Error: ${e.toString()}');
  } finally {
    client.close();
  }
}

class MediaControlCommands extends Command {
  final DBusRemoteObject player;

  MediaControlCommands(this.player) {
      addSubcommand(PlayPauseCmd(player));
      addSubcommand(GoNextCmd(player));
      addSubcommand(GoPreviousCmd(player));
      addSubcommand(GetTitleCmd(player));
      addSubcommand(GetArtistCmd(player));
      addSubcommand(GetStatusCmd(player));
      addSubcommand(ScrollCmd(player));
  }

  @override
  String get name => 'spotify';

  @override
  String get description => 'Control the media playback (play/pause, next, previous) or get metadata (status, song name, or artist name).';
  
  @override
  void run() async {
    if (argResults?['previous'])
      {await goPrevious(player);}
    else if (argResults?['status']) 
      {print(await getPlaybackStatus(player));}
  }
}

class PlayPauseCmd extends Command{
  final DBusRemoteObject player;
  
  PlayPauseCmd(this.player);
  
  @override
  String get name => 'playpause';

  @override
  String get description => 'plays / pauses spotify playback';

  @override
  void run() async{
    try {
      await playPause(player);
    } catch (e) {
      // 
    }
  }
}

class GoNextCmd extends Command{
  final DBusRemoteObject player;
  
  GoNextCmd(this.player);
  
  @override
  String get name => 'next';

  @override
  String get description => 'go to next song';

  @override
  void run() async {
    try {
      await goNext(player);
    } catch (e) {
     // 
    }
  }
}

class GoPreviousCmd extends Command{
  final DBusRemoteObject player;

  GoPreviousCmd(this.player);

  @override
  String get name => 'previous';

  @override
  String get description => 'go to previous song';

  @override
  void run() async{
    try {
      await goPrevious(player);
    } catch (e) {
     // 
    }
  }
}

class GetStatusCmd extends Command{
  final DBusRemoteObject player;

  GetStatusCmd(this.player);

  @override
  String get name => 'status';

  @override
  String get description => 'get current status of playback';

  @override
  void run() async{
    try {
      print(await getPlaybackStatus(player));
    } catch (e) {
      //
    }
  }
}

class GetArtistCmd extends Command{
  final DBusRemoteObject player;

  GetArtistCmd(this.player);

  @override
  String get name => 'artist';

  @override
  String get description => 'get name of artist of currently played song';

  @override
  void run() async{
    try {
      print(await getArtistName(player));
    } catch (e) {
      //
    }
  }
}

class GetTitleCmd extends Command{
  final DBusRemoteObject player;

  GetTitleCmd(this.player);

  @override
  String get name => 'title';

  @override
  String get description => 'get name of currently played song';

  @override
  void run() async{
    try {
      print(await getSongName(player));
    } catch (e) {
      //
    }
  }
}

class ScrollCmd extends Command {
  final DBusRemoteObject player;

  ScrollCmd(this.player) {
    argParser
      ..addOption(
        'display-length',
        abbr: 'd',
        defaultsTo: '30',
        help: 'The length displayed before text gets cut.',
      )
      ..addOption(
        'interval',
        abbr: 'i',
        defaultsTo: '1',
        help: 'The interval in seconds for updating (scrolling).',
      )
      ..addOption(
        'spacing',
        abbr: 's',
        defaultsTo: '10',
        help: 'The space left at the end of every scroll.',
      );
  }
 
  @override
  String get name => 'scroll';

  @override
  String get description => 'perpetually scroll song metadata';

  @override
  void run() async{
    final int displayLength = int.parse(argResults!['display-length']);
    final int intervalSeconds = int.parse(argResults!['interval']);
    final int spacing = int.parse(argResults!['spacing']);

    try {
      scrollMetaData(
        player,
        displayLength: displayLength,
        intervalSeconds: intervalSeconds,
        spacing: spacing
      );
    } catch (e) {
      //
    }
  }
}