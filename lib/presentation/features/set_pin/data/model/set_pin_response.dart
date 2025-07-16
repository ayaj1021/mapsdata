class SetPinResponse {
  final int? code;
  final String? status;
  final String? message;

  const SetPinResponse({this.code, this.status, this.message});

  factory SetPinResponse.fromJson(Map<String, dynamic> json) {
    return SetPinResponse(
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
