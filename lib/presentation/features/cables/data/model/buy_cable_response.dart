class BuyCableResponse {
  final int? code;
  final String? status;
  final String? message;

  BuyCableResponse({
    this.code,
    this.status,
    this.message,
  });

  factory BuyCableResponse.fromJson(Map<String, dynamic> json) {
    return BuyCableResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
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
