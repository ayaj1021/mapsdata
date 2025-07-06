class ValidateCardNumberResponse {
  int? code;
  String? status;
  String? name;
  String? type;

  ValidateCardNumberResponse({
    this.code,
    this.status,
    this.name,
    this.type,
  });

  factory ValidateCardNumberResponse.fromJson(Map<String, dynamic> json) {
    return ValidateCardNumberResponse(
      code: json['code'],
      status: json['status'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'name': name,
      'type': type,
    };
  }
}
