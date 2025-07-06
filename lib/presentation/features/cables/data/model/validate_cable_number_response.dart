class ValidateCableNumberResponse {
  final int? code;
  final String? status;
  final String? name;

  ValidateCableNumberResponse({
    this.code,
    this.status,
    this.name,
  });

  factory ValidateCableNumberResponse.fromJson(Map<String, dynamic> json) {
    return ValidateCableNumberResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'name': name,
    };
  }
}
