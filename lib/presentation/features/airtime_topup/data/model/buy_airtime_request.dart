class BuyAirtimeRequest {
  final String id;
  final String pin;
  final String number;
  final String amount;

  BuyAirtimeRequest({
    required this.id,
    required this.pin,
    required this.number,
    required this.amount,
  });

  factory BuyAirtimeRequest.fromJson(Map<String, dynamic> json) {
    return BuyAirtimeRequest(
      id: json['id'],
      pin: json['pin'],
      number: json['number'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pin': pin,
      'number': number,
      'amount': amount,
    };
  }
}
