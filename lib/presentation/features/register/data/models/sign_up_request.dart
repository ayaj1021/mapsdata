class SignUpRequest {
  final String firstname;
  final String lastname;
  final String email;
  final String number;
  final String username;
  final String password;
  final String referral;
  final String confirmPassword;

  const SignUpRequest({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.number,
    required this.username,
    required this.password,
    required this.referral,
    required this.confirmPassword,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return SignUpRequest(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      number: json['number'],
      username: json['username'],
      password: json['password'],
      referral: json['referral'],
      confirmPassword: json['confirm_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'number': number,
      'username': username,
      'password': password,
      'referral': referral,
      'confirm_password': confirmPassword,
    };
  }
}
