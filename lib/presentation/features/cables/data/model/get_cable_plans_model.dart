class CablePlansResponse {
  int? code;
  String? status;
  String? message;
  List<Cable>? cables;
  List<Plan>? plans;
  num? balance;
  bool? pin;

  CablePlansResponse({
    this.code,
    this.status,
    this.message,
    this.cables,
    this.plans,
    this.balance,
    this.pin,
  });

  factory CablePlansResponse.fromJson(Map<String, dynamic> json) {
    return CablePlansResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      cables: (json['cables'] as List?)?.map((e) => Cable.fromJson(e)).toList(),
      plans: (json['plans'] as List?)?.map((e) => Plan.fromJson(e)).toList(),
      balance: json['balance'],
      pin: json['pin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'cables': cables?.map((e) => e.toJson()).toList(),
      'plans': plans?.map((e) => e.toJson()).toList(),
      'balance': balance,
      'pin': pin,
    };
  }
}

class Cable {
  String? id;
  String? cable;
  String? chargeType;
  num? charge;

  Cable({
    this.id,
    this.cable,
    this.chargeType,
    this.charge,
  });

  factory Cable.fromJson(Map<String, dynamic> json) {
    return Cable(
      id: json['id'],
      cable: json['cable'],
      chargeType: json['charge_type'],
      charge: json['charge'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cable': cable,
      'charge_type': chargeType,
      'charge': charge,
    };
  }
}

class Plan {
  int? id;
  String? cable;
  String? cableId;
  String? plan;
  num? amount;

  Plan({
    this.id,
    this.cable,
    this.cableId,
    this.plan,
    this.amount,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      cable: json['cable'],
      cableId: json['cable_id'],
      plan: json['plan'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cable': cable,
      'cable_id': cableId,
      'plan': plan,
      'amount': amount,
    };
  }
}
