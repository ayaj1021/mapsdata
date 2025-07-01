class DataCardsResponse {
  final int? code;
  final String? status;
  final String? message;
  final List<DataCardsPlan>? plans;
  final List<Network>? networks;
  final int? balance;
  final bool? pin;

  DataCardsResponse({
    this.code,
    this.status,
    this.message,
    this.plans,
    this.networks,
    this.balance,
    this.pin,
  });

  factory DataCardsResponse.fromJson(Map<String, dynamic> json) {
    return DataCardsResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => DataCardsPlan.fromJson(e))
          .toList(),
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => Network.fromJson(e))
          .toList(),
      balance: json['balance'],
      pin: json['pin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'plans': plans?.map((e) => e.toJson()).toList(),
      'networks': networks?.map((e) => e.toJson()).toList(),
      'balance': balance,
      'pin': pin,
    };
  }
}

class DataCardsPlan {
  final String? id;
  final String? network;
  final String? plan;
  final String? type;
  final int? amount;

  DataCardsPlan({
    this.id,
    this.network,
    this.plan,
    this.type,
    this.amount,
  });

  factory DataCardsPlan.fromJson(Map<String, dynamic> json) {
    return DataCardsPlan(
      id: json['id'],
      network: json['network'],
      plan: json['plan'],
      type: json['type'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'network': network,
      'plan': plan,
      'type': type,
      'amount': amount,
    };
  }
}

class Network {
  final String? name;

  Network({this.name});

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
