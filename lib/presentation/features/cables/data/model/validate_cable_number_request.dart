class ValidateCableNumberRequest {
  final String id;
  final String cardNumber;

  const ValidateCableNumberRequest({
    required this.id,
    required this.cardNumber,
  });

  factory ValidateCableNumberRequest.fromJson(Map<String, dynamic> json) {
    return ValidateCableNumberRequest(
      id: json['id'] as String,
      cardNumber: json['card_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_number': cardNumber,
    };
  }
}
