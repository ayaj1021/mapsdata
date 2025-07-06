class GetDiscosResponse {
  int? code;
  String? status;
  String? message;
  List<Bill>? bills;
  num? balance;
  bool? pin;

  GetDiscosResponse({
    this.code,
    this.status,
    this.message,
    this.bills,
    this.balance,
    this.pin,
  });

  factory GetDiscosResponse.fromJson(Map<String, dynamic> json) {
    return GetDiscosResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      bills: (json['bills'] as List?)?.map((e) => Bill.fromJson(e)).toList(),
      balance: json['balance'],
      pin: json['pin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'bills': bills?.map((e) => e.toJson()).toList(),
      'balance': balance,
      'pin': pin,
    };
  }
}

class Bill {
  String? id;
  String? disco;
  String? name;
  String? chargeType;
  num? charge;

  Bill({
    this.id,
    this.disco,
    this.name,
    this.chargeType,
    this.charge,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'],
      disco: json['disco'],
      name: json['name'],
      chargeType: json['charge_type'],
      charge: json['charge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'disco': disco,
      'name': name,
      'charge_type': chargeType,
      'charge': charge,
    };
  }
}
