class BulkSmsResponse {
  final int? code;
  final String? status;
  final String? message;

  BulkSmsResponse({
    this.code,
    this.status,
    this.message,
  });

  factory BulkSmsResponse.fromJson(Map<String, dynamic> json) {
    return BulkSmsResponse(
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
