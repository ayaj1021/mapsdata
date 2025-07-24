class BuyElectricityResponse {
  final int? code;
  final String? status;
  final String? message;
  final String? service;
  final String? provider;
  final String? description;
  final String? phoneNumber;
  final String? amount;
  final String? type;
  final double? balanceBefore;
  final String? balanceAfter;
  final double? reference;
  final String? remark;
  final DateTime? date;

  BuyElectricityResponse({
    this.code,
    this.status,
    this.message,
    this.service,
    this.provider,
    this.description,
    this.phoneNumber,
    this.amount,
    this.type,
    this.balanceBefore,
    this.balanceAfter,
    this.reference,
    this.remark,
    this.date,
  });

  factory BuyElectricityResponse.fromJson(Map<String, dynamic> json) {
    return BuyElectricityResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      service: json['service'] as String?,
      provider: json['provider'] as String?,
      description: json['description'] as String?,
      phoneNumber: json['phone_number'] as String?,
      amount: json['amount'] as String?,
      type: json['type'] as String?,
      balanceBefore: (json['balance_before'] as num?)?.toDouble(),
      balanceAfter: json['balance_after']?.toString(),
      reference: (json['reference'] as num?)?.toDouble(),
      remark: json['remark'] as String?,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'service': service,
      'provider': provider,
      'description': description,
      'phone_number': phoneNumber,
      'amount': amount,
      'type': type,
      'balance_before': balanceBefore,
      'balance_after': balanceAfter,
      'reference': reference,
      'remark': remark,
      'date': date?.toIso8601String(),
    };
  }
}
