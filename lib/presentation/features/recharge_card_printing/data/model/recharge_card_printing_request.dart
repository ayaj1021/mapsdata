class RechargeCardPrintingRequest {
  final String id;
  final String pin;
  final String range;
  final String quantity;
  final String name;

  const RechargeCardPrintingRequest({
    required this.id,
    required this.pin,
    required this.range,
    required this.quantity,
    required this.name,
  });

  factory RechargeCardPrintingRequest.fromJson(Map<String, dynamic> json) {
    return RechargeCardPrintingRequest(
      id: json['id'] as String,
      pin: json['pin'] as String,
      range: json['range'] as String,
      quantity: json['quantity'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'range': range,
      'quantity': quantity,
      'name': name,
    };
  }
}
