class LinkBvnNinRequest {
  final String bvn;

  LinkBvnNinRequest({
    required this.bvn,
  });

  Map<String, dynamic> toJson() {
    return {
      'bvn': bvn,
    };
  }
}
