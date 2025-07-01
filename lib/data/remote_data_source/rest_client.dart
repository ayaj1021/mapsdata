import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/env/base_env.dart';
import 'package:mapsdata/core/config/env/prod_env.dart';
import 'package:mapsdata/core/config/interceptors/header_interceptor.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_request.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_response.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/fetch_airtime_list_model.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_request.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_response.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_bvn_nin_request.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_nin_bvn_response.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/virtual_account_response.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_request.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_response.dart';
import 'package:mapsdata/presentation/features/notification/data/model/get_notification_response.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_request.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_response.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/buy_exam_request.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/buy_exam_response.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/get_all_exams_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/user/register')
  Future<SignUpResponse> signUp(
    @Body() SignUpRequest signUpRequest,
  );

  @POST('/user/login')
  Future<LoginResponse> login(
    @Body() LoginRequest loginRequest,
  );

  @POST('/user/kyc/link-bvn-nin')
  Future<BvnLinkResponse> linkNinBvn(
    @Body() LinkBvnNinRequest loginRequest,
  );

  @POST('/data/plans')
  Future<GetDataPlansResponse> getDataPlansDetails();

  @POST('/airtime')
  Future<GetAirtimePlansResponse> getAirtimePlansDetails();

  @POST('/exam')
  Future<ExamResponse> getResultServices();

  @POST('/data/topup')
  Future<BuyDataResponse> buyData(
    @Body() BuyDataRequest request,
  );

  @POST('/exam/pin')
  Future<BuyExamResponse> buyExam(
    @Body() BuyExamRequest request,
  );

  @POST('/user/dashboard')
  Future<NotificationResponse> getNotifications();

  @POST('/fund-wallet/virtual-account')
  Future<VirtualAccountResponse> virtualAccount();

  @POST('/airtime/topup')
  Future<BuyAirtimeResponse> buyAirtime(
    @Body() BuyAirtimeRequest buyAirtimeRequest,
  );
}

ProviderFamily<Dio, BaseEnv> _dio = Provider.family<Dio, BaseEnv>(
  (ref, env) {
    final dio = Dio();
    dio.options.baseUrl = 'https://server.mapsdata.com.ng';
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'accept': 'application/json',
    };

    dio.interceptors.add(
      HeaderInterCeptor(
        dio: dio,
        secureStorage: ref.read(localStorageProvider),
        // onTokenExpired: () {
        //ref.read(logoutProvider.notifier).state = ActivityStatus.loggedOut;
        // },
      ),
    );
    return dio;
  },
);

final restClientProvider = Provider((_) {
  final env = switch (F.appFlavor) {
    Flavor.prod => ProdEnv(),
    // Flavor.staging => StagingEnv(),
    //Flavor.dev => DevEnv(),
  };
  return RestClient(_.read(_dio.call(env)));
});
