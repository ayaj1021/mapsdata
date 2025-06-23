class VirtualAccountResponse {
  final int? code;
  final String? status;
  final String? message;

  VirtualAccountResponse({
    this.code,
    this.status,
    this.message,
  });

  factory VirtualAccountResponse.fromJson(Map<String, dynamic> json) {
    return VirtualAccountResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
    };
  }
}
