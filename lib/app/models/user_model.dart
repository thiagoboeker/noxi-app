class UserModel {
  int id;
  int credits;
  String name;

  UserModel({this.id, this.credits, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        credits: json['credits'],
        name: json['name']
        );
  }

  Map<String, dynamic> toJson() => {};
}
