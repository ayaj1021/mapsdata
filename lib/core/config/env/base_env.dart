abstract class BaseEnv {
  String get baseUrl;
}

enum Flavor {
  prod('MapsData Prod');
  // dev('DigitSend Dev'),
  // staging('DigitSend Staging');

  const Flavor(this.title);
  final String title;
}

class F {
  static Flavor appFlavor = Flavor.prod;
}
