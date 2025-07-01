class BuyExamRequest {
  final String id;
  final String pin;
  final String quantity;

  BuyExamRequest({
    required this.id,
    required this.pin,
    required this.quantity,
  });

  factory BuyExamRequest.fromJson(Map<String, dynamic> json) {
    return BuyExamRequest(
      id: json['id'],
      pin: json['pin'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'quantity': quantity,
    };
  }
}
