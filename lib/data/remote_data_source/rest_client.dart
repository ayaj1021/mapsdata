import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/env/base_env.dart';
import 'package:mapsdata/core/config/env/prod_env.dart';
import 'package:mapsdata/core/config/interceptors/header_interceptor.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_request.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_response.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/fetch_airtime_list_model.dart';
import 'package:mapsdata/presentation/features/cables/data/model/buy_cable_request.dart';
import 'package:mapsdata/presentation/features/cables/data/model/buy_cable_response.dart';
import 'package:mapsdata/presentation/features/cables/data/model/get_cable_plans_model.dart';
import 'package:mapsdata/presentation/features/cables/data/model/validate_cable_number_request.dart';
import 'package:mapsdata/presentation/features/cables/data/model/validate_cable_number_response.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/buy_data_card_request.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/buy_data_card_response.dart';
import 'package:mapsdata/presentation/features/data_card/data/model/get_data_cards_response.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_request.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/buy_data_response.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/buy_electricity_request.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/buy_electricity_response.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/get_discos_response.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/validate_card_number_request.dart';
import 'package:mapsdata/presentation/features/electricity/data/model/validate_card_number_response.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_bvn_nin_request.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/link_nin_bvn_response.dart';
import 'package:mapsdata/presentation/features/fund_account/data/model/virtual_account_response.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_request.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_response.dart';
import 'package:mapsdata/presentation/features/notification/data/model/get_notification_response.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/get_recharge_printing_response.dart';
import 'package:mapsdata/presentation/features/recharge_card_printing/data/model/recharge_card_printing_request.dart';
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

  @POST('/data-card/plans')
  Future<DataCardsResponse> getDataCards();

  @POST('/cable/plans')
  Future<CablePlansResponse> getCablePlans();

  @POST('/bills')
  Future<GetDiscosResponse> getDiscos();

  @POST('/recharge-pin')
  Future<RechargeCardPrintingResponse> getRechargeCardPrinting();

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

  @POST('/data-card/purchase')
  Future<BuyDataCardResponse> buyDataCard(
    @Body() BuyDataCardRequest request,
  );

  @POST('/cable/validate')
  Future<ValidateCableNumberResponse> validateCableNumber(
    @Body() ValidateCableNumberRequest request,
  );

  @POST('/bills/validate')
  Future<ValidateCardNumberResponse> validateCardNumber(
    @Body() ValidateCardNumberRequest request,
  );

  @POST('/cable/subscription')
  Future<BuyCableResponse> buyCable(
    @Body() BuyCableRequest request,
  );

  @POST('/bills/payment')
  Future<BuyElectricityResponse> buyElectricity(
    @Body() BuyElectricityRequest request,
  );

  @POST('/recharge-pin/purchase')
  Future<RechargeCardPrintingResponse> rechargeCardPrinting(
    @Body() RechargeCardPrintingRequest request,
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
