import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/config/network_utils/async_response.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/data_topup/data/repository/get_all_data_service_repo.dart';
import 'package:mapsdata/presentation/features/data_topup/presentation/notifier/get_all_data_plans_state.dart';

class GetAllDataPlansNotifier
    extends AutoDisposeNotifier<GetAllDataPlansState> {
  GetAllDataPlansNotifier();

  late GetAllDataPlansRepository _getAllDataPlansRepository;

  @override
  GetAllDataPlansState build() {
    _getAllDataPlansRepository = ref.read(getAllDataPlansRepositoryProvider);

    return GetAllDataPlansState.initial();
  }

  Future<void> getAllDataPlans() async {
    state = state.copyWith(loadState: LoadState.loading);

    try {
      final value = await _getAllDataPlansRepository.getAllDataPlans();

      log("API Response: ${value.data?.data?.plans?.first}");

      // Check if value.data is a Map and can be cast
      if (value.data is Map<String, dynamic>) {
        final dataMap = value.data as Map<String, dynamic>;

        // Parse the response into GetDataPlansResponse
        final getDataPlansResponse = GetDataPlansResponse.fromJson(dataMap);

        // Set the state with the parsed data
        state = state.copyWith(
          loadState: LoadState.idle,
          getAllDataPlans: getDataPlansResponse,
        );
      } else {
        // Handle the case where data is not in the expected format
        throw Exception("Invalid data format");
      }

      // if (value.status == 'failed') throw value.message.toException;

      // state = state.copyWith(
      //     loadState: LoadState.idle,
      //     getAllDataPlans: GetDataPlansResponse.fromJson(
      //         value.data ));
    } catch (e) {
      state = state.copyWith(loadState: LoadState.idle);
    }
  }
}

final getAllDataPlansNotifierProvider =
    NotifierProvider.autoDispose<GetAllDataPlansNotifier, GetAllDataPlansState>(
        GetAllDataPlansNotifier.new);
