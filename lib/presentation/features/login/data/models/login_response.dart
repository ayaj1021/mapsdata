class LoginResponse {
  final int? code;
  final String? status;
  final String? message;
  final User? user;

  LoginResponse({
    this.code,
    this.status,
    this.message,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'user': user?.toJson(),
    };
  }
}

class User {
  final String? token;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? username;
  final String? phoneNumber;
  final String? apikey;
  final dynamic verification;

  User({
    this.token,
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.phoneNumber,
    this.apikey,
    this.verification,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      phoneNumber: json['phone_number'] as String?,
      apikey: json['apikey'] as String?,
      verification: json['verification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'username': username,
      'phone_number': phoneNumber,
      'apikey': apikey,
      'verification': verification,
    };
  }
}
