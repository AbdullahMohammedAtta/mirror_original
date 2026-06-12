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
      isAdmin: json['isAdmin'] ?? false,
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? 'https://static.vecteezy.com/system/resources/previews/007/296/447/non_2x/user-icon-in-flat-style-person-icon-client-symbol-vector.jpg',
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