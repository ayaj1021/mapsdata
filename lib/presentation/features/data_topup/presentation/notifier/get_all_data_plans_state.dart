import 'package:mapsdata/core/config/network_utils/async_response.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';

class GetAllDataPlansState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final String? message;
  final LoadState loadState;
 // final AsyncResponse<GetDataPlansResponse> getAllDataPlans;
  final GetDataPlansResponse getAllDataPlans;
  // final GetAllUserDetailsResponse getAllDetails;

  GetAllDataPlansState({
    required this.isLoading,
    required this.isAuthenticated,
    this.error,
    this.message,
    required this.loadState,
    required this.getAllDataPlans,
  });

  factory GetAllDataPlansState.initial() {
    return GetAllDataPlansState(
      isLoading: false,
      isAuthenticated: false,
      error: null,
      message: '',
      loadState: LoadState.loading,
    //  getAllDataPlans: AsyncResponse.loading(),
      getAllDataPlans: GetDataPlansResponse(),
  
    );
  }

  GetAllDataPlansState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    String? message,
    LoadState? loadState,
    GetDataPlansResponse? getAllDataPlans,
    //AsyncResponse<GetDataPlansResponse>? getAllDataPlans,
    //GetAllUserDetailsResponse? getAllDetails,
  }) {
    return GetAllDataPlansState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: message,
      loadState: loadState ?? this.loadState,
      getAllDataPlans: getAllDataPlans ?? this.getAllDataPlans,
    );
  }
}
