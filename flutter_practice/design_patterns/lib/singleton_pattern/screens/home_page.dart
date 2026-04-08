import 'package:flutter/material.dart';
import '../singleton/audio_manager.dart';
import '../core/song_model.dart';
import '../widgets/music_controls.dart';
import 'second_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Get the single global instance
  final AudioManager _audioManager = AudioManager();

  final List<Song> _playlist = [
    const Song(id: 's1', title: 'Beat It', artist: 'Michael Jackson', url: 'Beat It.mp3'),
    const Song(id: 's2', title: 'Billie Jean', artist: 'Michael Jackson', url: 'Billie Jean.mp3'),
    const Song(id: 's3', title: 'They Don\'t Care About Us', artist: 'Michael Jackson', url: 'They Don\'t Care About Us.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Singleton Pattern: Music App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'AudioManager HashCode: ${_audioManager.hashCode}\nThis proves the same instance is used everywhere.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _playlist.length,
              itemBuilder: (context, index) {
                final song = _playlist[index];              
                return StreamBuilder<Song?>(
                  stream: _audioManager.currentSongStream,
                  initialData: _audioManager.currentSong,
                  builder: (context, snapshot) {
                    final isPlayingThisSong = snapshot.data?.id == song.id; 
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.music_note)),
                      title: Text(song.title, style: TextStyle(fontWeight: isPlayingThisSong ? FontWeight.bold : FontWeight.normal)),
                      subtitle: Text(song.artist),
                      trailing: IconButton(
                        icon: Icon(
                          isPlayingThisSong && _audioManager.isPlaying ? Icons.pause_circle : Icons.play_circle,
                          color: isPlayingThisSong ? Colors.indigo : Colors.grey,
                          size: 32,
                        ),
                        onPressed: () {
                          if (isPlayingThisSong && _audioManager.isPlaying) {
                            _audioManager.pause();
                          } else {
                            _audioManager.play(song);
                          }
                          // trigger rebuild for UI
                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          // Global Now Playing Bar
          StreamBuilder<Song?>(
            stream: _audioManager.currentSongStream,
            initialData: _audioManager.currentSong,
            builder: (context, snapshot) {
              final currentSong = snapshot.data;
              if (currentSong == null) return const SizedBox.shrink();

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.indigo.shade50,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Now Playing', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text(currentSong.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const MusicControls(),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Go to Second Page (Observe state)'),
            ),
          ),
        ],
      ),
    );
  }
}
