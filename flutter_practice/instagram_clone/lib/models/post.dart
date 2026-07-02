import 'package:instagram_clone/models/user.dart';

class Post {
  final String image;
  final String description;
  final int likes;
  final int comments;
  final int shares;
  final int reposts;
  final int saved;
  final int views;

  Post({
    required this.image,
    required this.description,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.reposts,
    required this.saved,
    required this.views,
  });
}
