class BvnLinkResponse {
  final int? code;
  final String? status;
  final String? message;

  BvnLinkResponse({
    this.code,
    this.status,
    this.message,
  });

  factory BvnLinkResponse.fromJson(Map<String, dynamic> json) {
    return BvnLinkResponse(
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
