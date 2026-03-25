import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../core/song_model.dart';
import 'package:flutter/foundation.dart';

/// The Singleton class responsible for global audio playback.
class AudioManager {
  // 1. Private static instance
  static final AudioManager _instance = AudioManager._internal();

  // 2. Factory constructor returning the single instance
  factory AudioManager() {
    return _instance;
  }

  // 3. Private internal constructor for initialization
  AudioManager._internal() {
    debugPrint('--> Initialized AudioManager (HashCode: $hashCode) <--');
  }

  // --- Audio State ---
  final AudioPlayer _player = AudioPlayer();
  Song? _currentSong;
  bool _isPlaying = false;

  // Streams for UI updates
  final _songController = StreamController<Song?>.broadcast();
  final _playingController = StreamController<bool>.broadcast();

  Stream<Song?> get currentSongStream => _songController.stream;
  Stream<bool> get playingStream => _playingController.stream;

  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  Future<void> play(Song song) async {
    // If playing the same song, just resume
    if (_currentSong?.id == song.id) {
      await _player.resume();
    } else {
      // Different song: stop current and play new
      await stop();
      _currentSong = song;
      _songController.add(_currentSong);
      
      // Play actual asset
      await _player.play(AssetSource(song.url));
      debugPrint('Playing track: ${song.title}');
    }
    
    _isPlaying = true;
    _playingController.add(true);
  }

  Future<void> pause() async {
    await _player.pause();
    debugPrint('Paused: ${_currentSong?.title}');
    _isPlaying = false;
    _playingController.add(false);
  }

  Future<void> stop() async {
    await _player.stop();
    debugPrint('Stopped playing.');
    _isPlaying = false;
    _playingController.add(false);
  }

  void dispose() {
    _songController.close();
    _playingController.close();
    _player.dispose();
  }
}
