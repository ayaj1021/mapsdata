class BuyDataResponse {
  final int? code;
  final String? status;
  final String? message;

  BuyDataResponse({
    this.code,
    this.status,
    this.message,
  });

  factory BuyDataResponse.fromJson(Map<String, dynamic> json) {
    return BuyDataResponse(
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
