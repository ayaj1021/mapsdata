class ManualFundingResponse {
  final int? code;
  final String? status;
  final String? message;
  final AccountData? account;

  ManualFundingResponse({
    this.code,
    this.status,
    this.message,
    this.account,
  });

  factory ManualFundingResponse.fromJson(Map<String, dynamic> json) {
    return ManualFundingResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      account: json['account'] != null
          ? AccountData.fromJson(json['account'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'account': account?.toJson(),
    };
  }
}

class AccountData {
  final String? number;
  final String? name;
  final String? bankName;
  final String? ussdPayment;
  final int? accountDurationSeconds;
  final String? charge;
  final int? amount;
  final String? chargeType;

  AccountData({
    this.number,
    this.name,
    this.bankName,
    this.ussdPayment,
    this.accountDurationSeconds,
    this.charge,
    this.amount,
    this.chargeType,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return AccountData(
      number: json['number'] as String?,
      name: json['name'] as String?,
      bankName: json['bankName'] as String?,
      ussdPayment: json['ussdPayment'] as String?,
      accountDurationSeconds: json['accountDurationSeconds'] as int?,
      charge: json['charge'] as String?,
      amount: json['amount'] as int?,
      chargeType: json['chargeType'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'bankName': bankName,
      'ussdPayment': ussdPayment,
      'accountDurationSeconds': accountDurationSeconds,
      'charge': charge,
      'amount': amount,
      'chargeType': chargeType,
    };
  }
}
