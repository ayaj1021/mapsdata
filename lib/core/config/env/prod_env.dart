

import 'package:mapsdata/core/config/env/base_env.dart';

class ProdEnv implements BaseEnv {
  factory ProdEnv() => _instance;
  ProdEnv._internal();
  static final ProdEnv _instance = ProdEnv._internal();
  @override
  String get baseUrl =>
      'https://app.mapsdata.com.ng'; 

}
