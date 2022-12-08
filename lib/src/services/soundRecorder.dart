// Written by Ronald Gilliard Jr -> https://github.com/rongill23


import 'dart:io';

import 'package:communication_app/src/views/audioTest.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  Codec _codec = Codec.aacMP4;
  bool _isRecorderInitialised = false;
  static const theSource = AudioSource.microphone;
  bool get isRecording => _audioRecorder!.isRecording;
  var _directoryPath;
  var filePath;


  Future record() async {
    if(isRecording) return;
    await _audioRecorder!.startRecorder(toFile: filePath, audioSource: theSource, codec: _codec);
  }

  Future stop() async {
    if(!_audioRecorder!.isRecording) return;
    await _audioRecorder!.stopRecorder();
    File f = File(filePath);
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    final statusStorage = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Permission Denied");
    }

    if(statusStorage != PermissionStatus.granted){
      await Permission.storage.request();
    }

    await _audioRecorder!.openRecorder();
    var directory = await getApplicationDocumentsDirectory();
    _directoryPath = "${directory.path}/audio/";
    filePath = "${_directoryPath}audio.mp4";
    _isRecorderInitialised = true;
  }

  void dispose() async {
    if (!_isRecorderInitialised) return null;

    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }
}
