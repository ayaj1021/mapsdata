class SetPinRequest {
  final String pin;

  const SetPinRequest({required this.pin});

  factory SetPinRequest.fromJson(Map<String, dynamic> json) {
    return SetPinRequest(
      pin: json['pin'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pin': pin,
    };
  }
}
