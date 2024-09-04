

import 'package:mapsdata/core/config/env/base_env.dart';

class StagingEnv implements BaseEnv {
  factory StagingEnv() => _instance;
  StagingEnv._internal();
  static final StagingEnv _instance = StagingEnv._internal();
  @override
  String get baseUrl => 'https://digit-send-backend.onrender.com';
}
