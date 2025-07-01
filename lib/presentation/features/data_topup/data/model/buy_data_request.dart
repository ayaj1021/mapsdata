class BuyDataRequest {
  final String id;
  final String pin;
  final String number;

  const BuyDataRequest({
    required this.id,
    required this.pin,
    required this.number,
  });

  factory BuyDataRequest.fromJson(Map<String, dynamic> json) {
    return BuyDataRequest(
      id: json['id'] as String,
      pin: json['pin'] as String,
      number: json['number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'number': number,
    };
  }
}
