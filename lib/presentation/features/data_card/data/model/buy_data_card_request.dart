class BuyDataCardRequest {
  final String id;
  final String pin;
  final String quantity;
  final String name;

  const BuyDataCardRequest({
    required this.id,
    required this.pin,
    required this.quantity,
    required this.name,
  });

  factory BuyDataCardRequest.fromJson(Map<String, dynamic> json) {
    return BuyDataCardRequest(
      id: json['id'] as String,
      pin: json['pin'] as String,
      quantity: json['quantity'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'quantity': quantity,
      'name': name,
    };
  }
}
