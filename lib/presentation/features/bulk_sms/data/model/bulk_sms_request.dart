class BulkSmsRequest {
  final String service;
  final String sender;
  final String phoneNumber;
  final String message;

  BulkSmsRequest({
    required this.service,
    required this.sender,
    required this.phoneNumber,
    required this.message,
  });

  factory BulkSmsRequest.fromJson(Map<String, dynamic> json) {
    return BulkSmsRequest(
      service: json['service'],
      sender: json['sender'],
      phoneNumber: json['phoneNumber'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'sender': sender,
      'phoneNumber': phoneNumber,
      'message': message,
    };
  }
}
