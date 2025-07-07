class GetDataPlansResponse {
  final int? code;
  final String? status;
  final String? message;
  final List<Plan>? plans;
  final List<Prefix>? prefix;
  final List<Network>? networks;
  final List<dynamic>? beneficiaries;
  final num? balance;
  final bool? pin;

  GetDataPlansResponse({
    this.code,
    this.status,
    this.message,
    this.plans,
    this.prefix,
    this.networks,
    this.beneficiaries,
    this.balance,
    this.pin,
  });

  factory GetDataPlansResponse.fromJson(Map<String, dynamic> json) {
    return GetDataPlansResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
      prefix: (json['prefix'] as List<dynamic>?)
          ?.map((e) => Prefix.fromJson(e as Map<String, dynamic>))
          .toList(),
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
      beneficiaries: json['beneficiaries'] as List<dynamic>?,
      balance: json['balance'] as num?,
      pin: json['pin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'plans': plans?.map((e) => e.toJson()).toList(),
      'prefix': prefix?.map((e) => e.toJson()).toList(),
      'networks': networks?.map((e) => e.toJson()).toList(),
      'beneficiaries': beneficiaries,
      'balance': balance,
      'pin': pin,
    };
  }
}

class Plan {
  final String? id;
  final String? network;
  final String? plan;
  final String? type;
  final int? amount;

  Plan({
    this.id,
    this.network,
    this.plan,
    this.type,
    this.amount,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as String?,
      network: json['network'] as String?,
      plan: json['plan'] as String?,
      type: json['type'] as String?,
      amount: json['amount'] as int?,
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

class Prefix {
  final String? network;
  final String? prefix;

  Prefix({
    this.network,
    this.prefix,
  });

  factory Prefix.fromJson(Map<String, dynamic> json) {
    return Prefix(
      network: json['network'] as String?,
      prefix: json['prefix'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'network': network,
      'prefix': prefix,
    };
  }
}

class Network {
  final String? name;

  Network({this.name});

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
