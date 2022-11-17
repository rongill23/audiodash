// /*
//  * Copyright 2018, 2019, 2020, 2021 Dooboolab.
//  *
//  * This file is part of Flutter-Sound.
//  *
//  * Flutter-Sound is free software: you can redistribute it and/or modify
//  * it under the terms of the Mozilla Public License version 2 (MPL2.0),
//  * as published by the Mozilla organization.
//  *
//  * Flutter-Sound is distributed in the hope that it will be useful,
//  * but WITHOUT ANY WARRANTY; without even the implied warranty of
//  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  * MPL General Public License for more details.
//  *
//  * This Source Code Form is subject to the terms of the Mozilla Public
//  * License, v. 2.0. If a copy of the MPL was not distributed with this
//  * file, You can obtain one at https://mozilla.org/MPL/2.0/.
//  */

// import 'dart:async';
// import 'dart:io';
// import 'package:audio_session/audio_session.dart';
// import 'package:communication_app/src/services/soundPlayback.dart';
// import 'package:communication_app/src/services/soundRecorder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// /*
//  * This is an example showing how to record to a Dart Stream.
//  * It writes all the recorded data from a Stream to a File, which is completely stupid:
//  * if an App wants to record something to a File, it must not use Streams.
//  *
//  * The real interest of recording to a Stream is for example to feed a
//  * Speech-to-Text engine, or for processing the Live data in Dart in real time.
//  *
//  */

// ///
// typedef _Fn = void Function();

// /* This does not work. on Android we must have the Manifest.permission.CAPTURE_AUDIO_OUTPUT permission.
//  * But this permission is _is reserved for use by system components and is not available to third-party applications._
//  * Pleaser look to [this](https://developer.android.com/reference/android/media/MediaRecorder.AudioSource#VOICE_UPLINK)
//  *
//  * I think that the problem is because it is illegal to record a communication in many countries.
//  * Probably this stands also on iOS.
//  * Actually I am unable to record DOWNLINK on my Xiaomi Chinese phone.
//  *
//  */
// // const theSource = AudioSource.voiceUpLink;
// // const theSource = AudioSource.voiceDownlink;

// const theSource = AudioSource.microphone;
// final storageRef = FirebaseStorage.instance.ref('');
// final audioStorageRef = storageRef.child('audio/tau_file.mp4');
// final metaData = SettableMetadata(contentType: "video/mp4");

// /// Example app.
// class SimpleRecorder extends StatefulWidget {
//   static const routeName = "/recorder";
//   @override
//   _SimpleRecorderState createState() => _SimpleRecorderState();
// }

// class _SimpleRecorderState extends State<SimpleRecorder> {
//   Codec _codec = Codec.aacMP4;
//   String? _mPath = "";
//   FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
//   FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
//   bool _mPlayerIsInited = false;
//   bool _mRecorderIsInited = false;
//   bool _mplaybackReady = false;
//   final recorder = SoundRecorder();
//   final player = SoundPlayback();

//   @override
//   void initState() {
//     recorder.init().then((value) {
//       _mRecorderIsInited = true;
//     });
//     _mPath = recorder.filePath;
//     player.init(_mPath).then((value) {
//       setState(() {
//         _mPlayerIsInited = true;
//       });
//     });

//     // _mPlayer!.openPlayer().then((value) {
//     //   setState(() {

//     //     print("Hwody");
//     //     _mPlayerIsInited = true;
//     //   });
//     // });

//     // openTheRecorder().then((value) {
//     //   setState(() {
//     //     _mRecorderIsInited = true;
//     //   });
//     // });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     recorder.dispose();
//     player.dispose();
//     // _mPlayer!.closePlayer();
//     // _mPlayer = null;

//     // _mRecorder!.closeRecorder();
//     // _mRecorder = null;
//     super.dispose();
//   }

//   Future<void> openTheRecorder() async {
//     var status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw RecordingPermissionException('Microphone permission not granted');
//     }

//     await _mRecorder!.openRecorder();
//     // if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
//     //   _codec = Codec.opusWebM;
//     //   _mPath = 'tau_file.webm';
//     //   if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
//     //     _mRecorderIsInited = true;
//     //     return;
//     //   }
//     // }
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions:
//           AVAudioSessionCategoryOptions.allowBluetooth |
//               AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy:
//           AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));

//     _mRecorderIsInited = true;
//   }

//   // ----------------------  Here is the code for recording and playback -------

//   void record() {
//     recorder.record().then((value) {
//       setState() {}
//     });
//     // _mRecorder!
//     //     .startRecorder(
//     //   toFile: _mPath,
//     //   codec: _codec,
//     //   audioSource: theSource,
//     // )
//     //     .then((value) {
//     //   setState(() {});
//     // });
//   }

//   void stopRecorder() async {
//     await recorder.stop().then((value) async {
//       _mplaybackReady = true;
//       setState(() {});
//     });

//     // await _mRecorder!.stopRecorder().then((value) async {
//     //   setState(() {
//     //     //var url = value;
//     //     _mplaybackReady = true;
//     //   });

//     //   try {
//     //     print(File(_mPath));
//     //     await audioStorageRef.putFile(File(_mPath), metaData).then((p0) {
//     //       print(p0.toString());
//     //       print("\n\n Howdyyyyyyyyyyyyyyyyyyyy");
//     //     });
//     //   } on Exception catch (e) {
//     //     print(e);
//     //     print("\n\n Howdyyyyyyyyyyyyyyyyyyyy");
//     //   }
//     // });
//   }

//   void play() {
//     // assert(_mPlayerIsInited &&
//     //     _mplaybackReady &&
//     //     _mRecorder!.isStopped &&
//     //     _mPlayer!.isStopped);
//     player.play().then((value) {
//       setState(() {});
//     });
//     // assert(_mPlayerIsInited &&
//     //     _mplaybackReady &&
//     //     _mRecorder!.isStopped &&
//     //     _mPlayer!.isStopped);
//     // _mPlayer!
//     //     .startPlayer(
//     //         fromURI: _mPath,
//     //         //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
//     //         whenFinished: () {
//     //           setState(() {});
//     //         })
//     //     .then((value) {
//     //   setState(() {});
//     // });
//   }

//   void stopPlayer() {
//     player.stop().then((value) {
//       setState(() {});
//     });
//     // _mPlayer!.stopPlayer().then((value) {
//     //   setState(() {});
//     // });
//   }

// // ----------------------------- UI --------------------------------------------

//   _Fn? getRecorderFn() {
//     if (!_mRecorderIsInited || player!.isPlaying) {
//       return null;
//     }
//     return recorder.isRecording ? stopRecorder : record;
//   }

//   _Fn? getPlaybackFn() {
//     if (!_mPlayerIsInited || !_mplaybackReady || recorder!.isRecording) {
//       return null;
//     }
//     return player.isPlaying ? stopPlayer : play;
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget makeBody() {
//       return Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(3),
//             padding: const EdgeInsets.all(3),
//             height: 80,
//             width: double.infinity,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Color(0xFFFAF0E6),
//               border: Border.all(
//                 color: Colors.indigo,
//                 width: 3,
//               ),
//             ),
//             child: Row(children: [
//               ElevatedButton(
//                 onPressed: () {
//                   if (recorder.isRecording) {
//                     stopRecorder();
//                   }

//                   if (player.isPlaying || !recorder.isRecording) {
//                     stopPlayer();
//                     record();
//                   }
//                 },
//                 child: Text(recorder.isRecording ? 'Stop' : 'Record'),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                   recorder.isRecording
//                       ? 'Recording in progress'
//                       : 'Recorder is stopped',
//                   style: TextStyle(color: Colors.black)),
//             ]),
//           ),
//           Container(
//             margin: const EdgeInsets.all(3),
//             padding: const EdgeInsets.all(3),
//             height: 80,
//             width: double.infinity,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: Color(0xFFFAF0E6),
//               border: Border.all(
//                 color: Colors.indigo,
//                 width: 3,
//               ),
//             ),
//             child: Row(children: [
//               ElevatedButton(
//                 onPressed: () {
//                   if (player.isPlaying) {
//                     stopPlayer();
//                   }
//                   if (recorder.isRecording || !player.isPlaying) {
//                     stopRecorder();
//                     play();
//                   }
//                 },
//                 child: Text(player.isPlaying ? 'Stop' : 'Play'),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                   player.isPlaying
//                       ? 'Playback in progress'
//                       : 'Player is stopped',
//                   style: TextStyle(color: Colors.black)),
//             ]),
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * 0.15,
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.mic_rounded,
//                       size: 30,
//                     )),
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.play_arrow,
//                       size: 30,
//                     )),
//               ],
//             ),
//           ),
//         ],
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: const Text('Simple Recorder'),
//       ),
//       body: makeBody(),
//     );
//   }
// }
/*
 * Copyright 2018, 2019, 2020, 2021 Dooboolab.
 *
 * This file is part of Flutter-Sound.
 *
 * Flutter-Sound is free software: you can redistribute it and/or modify
 * it under the terms of the Mozilla Public License version 2 (MPL2.0),
 * as published by the Mozilla organization.
 *
 * Flutter-Sound is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * MPL General Public License for more details.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'dart:async';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:communication_app/src/data/store.dart';
import 'package:communication_app/src/services/firebaseMethods.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vxstate/vxstate.dart';

/*
 * This is an example showing how to record to a Dart Stream.
 * It writes all the recorded data from a Stream to a File, which is completely stupid:
 * if an App wants to record something to a File, it must not use Streams.
 *
 * The real interest of recording to a Stream is for example to feed a
 * Speech-to-Text engine, or for processing the Live data in Dart in real time.
 *
 */

///
typedef _Fn = void Function();

const theSource = AudioSource.microphone;
final storageRef = FirebaseStorage.instance.ref('');
final audioStorageRef = storageRef.child('audio/tau_file.mp4');
final metaData = SettableMetadata(contentType: "video/mp4");

/// Example app.
class SimpleRecorder extends StatefulWidget {
  const SimpleRecorder({Key? key}) : super(key: key);

 
  static const routeName = "/recorder";
  @override
  _SimpleRecorderState createState() => _SimpleRecorderState();
}

class _SimpleRecorderState extends State<SimpleRecorder> {
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  String groupID = "";
  FirebaseMethods methods = FirebaseMethods();
  MyStore store = VxState.store as MyStore;

  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      File file = File(value.toString());
      setState(() {
        //var url = value;
        _mplaybackReady = true;

        debugPrint(value.toString());
        debugPrint(file.toString());
      });

      try {
        methods.createAudioMessage(
            file, {"groupID": store.groupID, "userID": store.user.userID});

        audioStorageRef.putFile(file, metaData).then((p0) {
          print("\n\n Done");
        });
      } on Exception catch (e) {
        print(e);
        print("\n\n Howdyyyyyyyyyyyyyyyyyyyy");
      }
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getRecorderFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mRecorder!.isRecording
                  ? 'Recording in progress'
                  : 'Recorder is stopped'),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mPlayer!.isPlaying
                  ? 'Playback in progress'
                  : 'Player is stopped'),
            ]),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Simple Recorder'),
      ),
      body: makeBody(),
    );
  }
}
