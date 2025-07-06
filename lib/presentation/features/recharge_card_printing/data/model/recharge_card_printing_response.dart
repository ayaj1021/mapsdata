class RechargeCardPrintingResponse {
  final int? code;
  final String? status;
  final String? message;

  RechargeCardPrintingResponse({
    this.code,
    this.status,
    this.message,
  });

  factory RechargeCardPrintingResponse.fromJson(Map<String, dynamic> json) {
    return RechargeCardPrintingResponse(
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
