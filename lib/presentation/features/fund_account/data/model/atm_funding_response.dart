class AtmFundingResponse {
  final int? code;
  final String? status;
  final String? message;
  final PaystackData? paystack;
  final MonnifyData? monnify;

  AtmFundingResponse({
    this.code,
    this.status,
    this.message,
    this.paystack,
    this.monnify,
  });

  factory AtmFundingResponse.fromJson(Map<String, dynamic> json) {
    return AtmFundingResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      paystack: json['paystack'] != null
          ? PaystackData.fromJson(json['paystack'])
          : null,
      monnify: json['monnify'] != null
          ? MonnifyData.fromJson(json['monnify'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'paystack': paystack?.toJson(),
      'monnify': monnify?.toJson(),
    };
  }
}

class PaystackData {
  final int? charge;
  final String? status;

  PaystackData({this.charge, this.status});

  factory PaystackData.fromJson(Map<String, dynamic> json) {
    return PaystackData(
      charge: json['charge'] as int?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'charge': charge,
      'status': status,
    };
  }
}

class MonnifyData {
  final int? charge;
  final String? status;

  MonnifyData({this.charge, this.status});

  factory MonnifyData.fromJson(Map<String, dynamic> json) {
    return MonnifyData(
      charge: json['charge'] as int?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'charge': charge,
      'status': status,
    };
  }
}
