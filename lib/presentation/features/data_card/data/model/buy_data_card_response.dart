class BuyDataCardResponse {
  final int? code;
  final String? status;
  final String? message;

  BuyDataCardResponse({
    this.code,
    this.status,
    this.message,
  });

  factory BuyDataCardResponse.fromJson(Map<String, dynamic> json) {
    return BuyDataCardResponse(
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
