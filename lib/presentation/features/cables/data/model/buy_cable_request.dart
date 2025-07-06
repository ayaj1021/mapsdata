class BuyCableRequest {
  final String id;
  final String pin;
  final String number;
  final String cardNumber;

  const BuyCableRequest({
    required this.id,
    required this.pin,
    required this.number,
    required this.cardNumber,
  });

  factory BuyCableRequest.fromJson(Map<String, dynamic> json) {
    return BuyCableRequest(
      id: json['id'] as String,
      pin: json['pin'] as String,
      number: json['number'] as String,
      cardNumber: json['cardNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'number': number,
      'cardNumber': cardNumber,
    };
  }
}
