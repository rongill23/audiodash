// Written by Ronald Gilliard Jr -> https://github.com/rongill23


import 'package:flutter_sound/flutter_sound.dart';

class SoundPlayback {
  String? _pathToFile;
  FlutterSoundPlayer? _player;
  Codec _codec = Codec.aacMP4;
  bool _playerInitiliased = false;
  bool get isPlaying => _player!.isPlaying;

  Future init(pathToFile) async {
    _pathToFile = pathToFile;
    _player = FlutterSoundPlayer();
    _playerInitiliased = true;

    await _player!.openPlayer();
  }

  Future togglePlayer() async {
    if (_player!.isPlaying) {
      await _player!.stopPlayer();
    } else {
      await _player!.startPlayer(fromURI: _pathToFile);
    }
  }

  Future play() async {
    if (isPlaying) return;
    await _player!.startPlayer(
      fromURI: _pathToFile,
      whenFinished: () {},
    );
  }

  Future stop() async {
    if (!isPlaying) return;
    await _player!.stopPlayer();
  }

  void dispose() async {
    if (!_playerInitiliased) return null;
    await _player!.closePlayer();
    _player = null;
    _playerInitiliased = false;
  }
}
