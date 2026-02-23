class Comicmodel {
  String name;
  String publisher;
  String gender;
  String occupation;
  String image;

  Comicmodel({
    required this.name,
    required this.publisher,
    required this.gender,
    required this.occupation,
    required this.image,
  });

  factory Comicmodel.fromJson(Map<String, dynamic> json) {
    return Comicmodel(
      name: json['name'] ?? "",
      publisher: json['biography']?['publisher'] ?? "Unknown",
      gender: json['appearance']?['gender'] ?? "Unknown",
      occupation: json['work']?['occupation'] ?? "Unknown",
      image: json['images']?['sm'] ?? "",
    );
  }
}