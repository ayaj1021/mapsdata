class ManualFundingRequest {
  final String amount;

  ManualFundingRequest({
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}
