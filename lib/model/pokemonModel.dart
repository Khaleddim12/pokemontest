class pokemnModel {
  int? id;
  String name;
  String imageUrl;
  String? artist;

  pokemnModel(
      {this.id, required this.name, required this.imageUrl, this.artist});

  factory pokemnModel.fromJson(Map<String, dynamic> json) {
    return pokemnModel(
      name: json['name'] ?? "",
      imageUrl: json['images']['small'] ?? "",
      artist: json['artist'] ?? "",
    );
  }
}
