class User {
  final String id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
    );
  }
}