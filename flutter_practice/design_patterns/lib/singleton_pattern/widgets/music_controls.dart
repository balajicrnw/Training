import 'package:flutter/material.dart';
import '../singleton/audio_manager.dart';

/// A reusable generic widget that hooks into the Singleton AudioManager.
class MusicControls extends StatelessWidget {
  const MusicControls({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the singleton instance
    final audioManager = AudioManager();

    return StreamBuilder<bool>(
      stream: audioManager.playingStream,
      initialData: audioManager.isPlaying,
      builder: (context, snapshot) {
        final isPlaying = snapshot.data ?? false;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 32,
              icon: const Icon(Icons.stop_circle_outlined),
              onPressed: audioManager.currentSong == null ? null : () => audioManager.stop(),
            ),
            const SizedBox(width: 16),
            IconButton(
              iconSize: 48,
              color: Theme.of(context).primaryColor,
              icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill),
              onPressed: audioManager.currentSong == null
                  ? null
                  : () {
                      if (isPlaying) {
                        audioManager.pause();
                      } else {
                        audioManager.play(audioManager.currentSong!);
                      }
                    },
            ),
          ],
        );
      },
    );
  }
}
