class UserModel {
  final String uId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String image;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
  });

  // FROM JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
    };
  }
}