class TransactionResponse {
  int? currentPage;
  List<TransactionData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<PaginationLink>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  TransactionResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      currentPage: json['current_page'],
      data: (json['data'] as List?)
          ?.map((e) => TransactionData.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List?)
          ?.map((e) => PaginationLink.fromJson(e))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class TransactionData {
  int? id;
  String? status;
  String? service;
  String? provider;
  String? description;
  String? phoneNumber;
  String? amount;
  String? type;
  String? balanceBefore;
  String? balanceAfter;
  String? reference;
  String? remark;
  String? date;

  TransactionData({
    this.id,
    this.status,
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

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      status: json['status'],
      service: json['service'],
      provider: json['provider'],
      description: json['description'],
      phoneNumber: json['phone_number'],
      amount: json['amount'],
      type: json['type'],
      balanceBefore: json['balance_before'],
      balanceAfter: json['balance_after'],
      reference: json['reference'],
      remark: json['remark'] == 'null' ? null : json['remark'],
      date: json['date'],
    );
  }
}

class PaginationLink {
  String? url;
  String? label;
  bool? active;

  PaginationLink({this.url, this.label, this.active});

  factory PaginationLink.fromJson(Map<String, dynamic> json) {
    return PaginationLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}

extension TransactionResponseCopyWith on TransactionResponse {
  TransactionResponse copyWith({
    int? currentPage,
    List<TransactionData>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<PaginationLink>? links,
    String? nextPageUrl,
    String? path,
    String? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) {
    return TransactionResponse(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }
}
