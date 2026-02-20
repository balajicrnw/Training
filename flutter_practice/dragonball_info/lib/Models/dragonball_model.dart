class DragonBallModel {
  String name;
  String image;

  DragonBallModel({required this.name, required this.image});

  factory DragonBallModel.fromJson(Map<String, dynamic> json) {
    return DragonBallModel(
      name: json['name'],
      image: json['image'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
