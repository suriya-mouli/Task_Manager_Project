class UserModel {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final String mobile;

  String get fullName {
    return '$firstname $lastname';
  }

  UserModel({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.mobile,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      id: jsonData['_id'],
      email: jsonData['email'],
      firstname: jsonData['firstname'],
      lastname: jsonData['lastname'],
      mobile: jsonData['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'mobile': mobile,
    };
  }
}
