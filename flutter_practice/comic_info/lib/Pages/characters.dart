import 'package:comic_info/Models/ComicModel.dart';
import 'package:comic_info/Router/router_names.dart';
import 'package:comic_info/Service/Comicservice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersState();
}

class _CharactersState extends State<CharactersPage> {
  final Comicservice _comicservice = Comicservice();
  List<Comicmodel>? _characters;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final data = await _comicservice.fetchComic();
      if (mounted) {
        setState(() {
          _characters = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters'),leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.goNamed(RouterNames.home);
      },),),
      
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text("Error: $_errorMessage"));
    }

    if (_characters == null || _characters!.isEmpty) {
      return const Center(child: Text("No characters found"));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: _characters!.length,
      itemBuilder: (context, index) {
        final hero = _characters![index];

        return InkWell(
          onTap: () {
            context.goNamed(RouterNames.detail, extra: hero,pathParameters: {
    'name': hero.name,  
  },);
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: hero.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:Tooltip(
                      message: hero.name,
                      child: Image.network(
                        hero.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Text(hero.name, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}