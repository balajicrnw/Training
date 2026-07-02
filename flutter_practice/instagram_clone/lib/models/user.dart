import 'post.dart';

class User {
  final String userName;
  final String profileImage;
  final Post post;
  final int followers;
  final int following;
  final String description;

  User({
    required this.userName,
    required this.profileImage,
    required this.post,
    required this.followers,
    required this.following,
    required this.description,
  });
}
