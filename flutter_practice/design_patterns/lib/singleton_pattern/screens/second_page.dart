import 'package:flutter/material.dart';
import '../singleton/audio_manager.dart';
import '../core/song_model.dart';
import '../widgets/music_controls.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Get the single global instance again.
    // Notice how it doesn't create a new instance, it returns the existing one.
    final audioManager = AudioManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page Playback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.queue_music, size: 80, color: Colors.indigo),
            const SizedBox(height: 16),
            Text(
              'AudioManager HashCode: ${audioManager.hashCode}\n(Same as Home Page!)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 48),
            StreamBuilder<Song?>(
              stream: audioManager.currentSongStream,
              initialData: audioManager.currentSong,
              builder: (context, snapshot) {
                final song = snapshot.data;

                return Column(
                  children: [
                    Text(
                      song?.title ?? 'No song playing',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      song?.artist ?? '',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 48),
            const MusicControls(),
          ],
        ),
      ),
    );
  }
}
