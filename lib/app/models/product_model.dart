class ProductModel {
  int id;
  String name;
  String imageUrl;
  int price;
  int points;


  ProductModel({this.id, this.name, this.imageUrl, this.price, this.points});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      price: json['price'],
      points: json['points'],
        );
  }

  Map<String, dynamic> toJson() => {};
}
