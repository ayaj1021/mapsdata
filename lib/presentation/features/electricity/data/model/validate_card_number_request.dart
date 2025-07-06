class ValidateCardNumberRequest {
  final String id;
  final String meterNumber;
  final String type;

  const ValidateCardNumberRequest({
    required this.id,
    required this.meterNumber,
    required this.type,
  });

  factory ValidateCardNumberRequest.fromJson(Map<String, dynamic> json) {
    return ValidateCardNumberRequest(
      id: json['id'] as String,
      meterNumber: json['meter_number'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meter_number': meterNumber,
      'type': type,
    };
  }
}
