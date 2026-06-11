class UserModel {
  final String uId;
  final bool isAdmin;
  final String name;
  final String email;
  final String phone;
  final String image;


  UserModel({
    required this.uId,
    required this.isAdmin,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  // FROM JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] ?? '',
      name: json['name'] ?? '',
      isAdmin: json['isAdmin'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // TO JSON
  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'isAdmin': isAdmin,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}