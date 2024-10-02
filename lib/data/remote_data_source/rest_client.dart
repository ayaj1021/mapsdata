import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/env/base_env.dart';
import 'package:mapsdata/core/config/env/prod_env.dart';
import 'package:mapsdata/core/config/interceptors/header_interceptor.dart';
import 'package:mapsdata/core/database/local_storage_impl.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_request.dart';
import 'package:mapsdata/presentation/features/login/data/models/login_response.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_request.dart';
import 'package:mapsdata/presentation/features/register/data/models/sign_up_response.dart';
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

  @GET('/api/data/plans')
  Future<GetDataPlansResponse> getDataPlansDetails(
      // @Queries() Map<String, dynamic> queries,
      );

//   @POST('/auth/create-pin')
//   Future<BaseResponse<LoginResponse>> createPin(
//     @Body() CreatePinRequest loginRequest,
//   );

//   @POST('/auth/resend-otp')
//   Future<BaseResponse<dynamic>> resendOTP(
//     @Body() ResendOtpRequest request,
//   );

//   @POST('/auth/verify-reset-otp')
//   Future<BaseResponse<VerifyResetPasswordOtpResponse>> verifyResetPasswordOtp(
//     @Body() ResetPasswordOtpRequest request,
//   );

//   @POST('/auth/reset-password')
//   Future<BaseResponse<ResetPasswordResponse>> resetPassword(
//     @Body() ResetPasswordRequest request,
//   );

//   @POST('/auth/verify-signup-otp')
//   Future<BaseResponse<LoginResponse>> verifySignUpOtp(
//     @Body() VerifyOtpRequest request,
//   );

//   @POST('/auth/update-password')
//   Future<BaseResponse<ChangePasswordResponse>> changePassword(
//     @Body() ChangePasswordRequest request,
//   );

//   @GET('/bills/providers/{name}')
//   Future<BaseResponse<List<BillPaymentProvider>>> getBillPaymentProviders(
//     @Path() String name,
//   );

//   @GET('/bills/packages/{providerId}')
//   Future<BaseResponse<List<ProviderPackage>>> getPackages(
//     @Path() String providerId,
//   );

//   @POST('/bills/pay')
//   Future<BaseResponse<BillPaymentResponse>> makeBillPayment(
//     @Body() MakeBillPaymentRequest body,
//   );

//   @POST('/auth/forgot-password')
//   Future<BaseResponse<dynamic>> forgotPassword(
//     @Body() ForgotPasswordRequest body,
//   );

//   @GET('/bills/verify-recipient/{providerId}/{recipient}')
//   Future<BaseResponse<LookupRecipientResponse>> lookupRecipient(
//     @Path() String providerId,
//     @Path() String recipient,
//   );

//   @GET('/transactions')
//   Future<BaseResponse<TransactionResponse>> getTransactions(
//     @Queries() Map<String, dynamic> queries,
//   );

//   @GET('/transactions/{id}')
//   Future<BaseResponse<SingleTransactionResponse>> getTransactionDetails({
//     @Path() required String id,
//   });

//   @POST('/auth/logout')
//   Future<BaseResponse<dynamic>> logout();

//   @GET('/currencies')
//   Future<BaseResponse<List<ExchangeCurrency>>> getCurrencies();

//   @GET('/wallet')
//   Future<BaseResponse<Wallet>> getWallet();

//   @POST('/verification/level-1')
//   Future<BaseResponse<dynamic>> levelOneVerification(
//     @Body() LevelOneVerfificationModel body,
//   );
// }
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
