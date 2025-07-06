class BuyElectricityRequest {
  final String id;
  final String pin;
  final String number;
  final String type;
  final String meterNumber;
  final String amount;

  BuyElectricityRequest({
    required this.id,
    required this.pin,
    required this.number,
    required this.type,
    required this.meterNumber,
    required this.amount,
  });

  factory BuyElectricityRequest.fromJson(Map<String, dynamic> json) {
    return BuyElectricityRequest(
      id: json['id'],
      pin: json['pin'],
      number: json['number'],
      type: json['type'],
      meterNumber: json['meterNumber'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'number': number,
      'type': type,
      'meterNumber': meterNumber,
      'amount': amount,
    };
  }
}
