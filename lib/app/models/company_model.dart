class CompanyModel {
  int id;
  String name;
  String imageUrl;

  CompanyModel({this.id, this.name, this.imageUrl});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url']
    );
  }

  Map<String, dynamic> toJson() => {};
}
