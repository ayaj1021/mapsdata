class BuyExamResponse {
  final int? code;
  final String? status;
  final String? message;

  BuyExamResponse({
    this.code,
    this.status,
    this.message,
  });

  factory BuyExamResponse.fromJson(Map<String, dynamic> json) {
    return BuyExamResponse(
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
