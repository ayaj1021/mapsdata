class BuyElectricityResponse {
  final int? code;
  final String? status;
  final String? message;

  BuyElectricityResponse({
    this.code,
    this.status,
    this.message,
  });

  factory BuyElectricityResponse.fromJson(Map<String, dynamic> json) {
    return BuyElectricityResponse(
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
