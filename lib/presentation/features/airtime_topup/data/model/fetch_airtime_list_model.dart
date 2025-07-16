class GetAirtimePlansResponse {
  int? code;
  String? status;
  String? message;
  List<AirtimeItem>? airtime;
  List<PrefixItem>? prefix;
  List<NetworkItem>? networks;
  List<dynamic>? beneficiaries;
  num? balance;
  bool? pin;

  GetAirtimePlansResponse({
    this.code,
    this.status,
    this.message,
    this.airtime,
    this.prefix,
    this.networks,
    this.beneficiaries,
    this.balance,
    this.pin,
  });

  factory GetAirtimePlansResponse.fromJson(Map<String, dynamic> json) {
    return GetAirtimePlansResponse(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      airtime: (json['airtime'] as List?)
          ?.map((e) => AirtimeItem.fromJson(e))
          .toList(),
      prefix: (json['prefix'] as List?)
          ?.map((e) => PrefixItem.fromJson(e))
          .toList(),
      networks: (json['networks'] as List?)
          ?.map((e) => NetworkItem.fromJson(e))
          .toList(),
      beneficiaries: json['beneficiaries'] as List?,
      balance: json['balance'],
      pin: json['pin'],
    );
  }
}

class AirtimeItem {
  String? id;
  String? network;
  String? type;
  int? discount;

  AirtimeItem({this.id, this.network, this.type, this.discount});

  factory AirtimeItem.fromJson(Map<String, dynamic> json) {
    return AirtimeItem(
      id: json['id'],
      network: json['network'],
      type: json['type'],
      discount: json['discount'],
    );
  }
}

class PrefixItem {
  String? network;
  String? prefix;

  PrefixItem({this.network, this.prefix});

  factory PrefixItem.fromJson(Map<String, dynamic> json) {
    return PrefixItem(
      network: json['network'],
      prefix: json['prefix'],
    );
  }
}

class NetworkItem {
  String? name;

  NetworkItem({this.name});

  factory NetworkItem.fromJson(Map<String, dynamic> json) {
    return NetworkItem(
      name: json['name'],
    );
  }
}
