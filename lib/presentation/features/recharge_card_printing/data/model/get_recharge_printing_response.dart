class RechargeCardPrintingResponse {
  final int? code;
  final String? status;
  final String? message;
  final List<RechargeItem>? recharge;
  final List<RangeItem>? range;
  final int? balance;
  final bool? pin;

  RechargeCardPrintingResponse({
    this.code,
    this.status,
    this.message,
    this.recharge,
    this.range,
    this.balance,
    this.pin,
  });

  factory RechargeCardPrintingResponse.fromJson(Map<String, dynamic> json) {
    return RechargeCardPrintingResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      recharge: (json['recharge'] as List<dynamic>?)
          ?.map((e) => RechargeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      range: (json['range'] as List<dynamic>?)
          ?.map((e) => RangeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: json['balance'] as int?,
      pin: json['pin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'recharge': recharge?.map((e) => e.toJson()).toList(),
      'range': range?.map((e) => e.toJson()).toList(),
      'balance': balance,
      'pin': pin,
    };
  }
}

class RechargeItem {
  final String? id;
  final String? network;
  final int? charge;
  final String? chargeType;

  RechargeItem({
    this.id,
    this.network,
    this.charge,
    this.chargeType,
  });

  factory RechargeItem.fromJson(Map<String, dynamic> json) {
    return RechargeItem(
      id: json['id'] as String?,
      network: json['network'] as String?,
      charge: json['charge'] as int?,
      chargeType: json['charge_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'network': network,
      'charge': charge,
      'charge_type': chargeType,
    };
  }
}

class RangeItem {
  final String? id;
  final int? range;

  RangeItem({
    this.id,
    this.range,
  });

  factory RangeItem.fromJson(Map<String, dynamic> json) {
    return RangeItem(
      id: json['id'] as String?,
      range: json['range'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'range': range,
    };
  }
}
