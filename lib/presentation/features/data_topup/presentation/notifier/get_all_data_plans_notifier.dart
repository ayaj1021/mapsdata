import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/data_topup/data/model/get_data_response_model.dart';
import 'package:mapsdata/presentation/features/data_topup/data/repository/get_all_data_service_repo.dart';

class GetAllDataPlansNotifier
    extends AutoDisposeNotifier<BaseState<GetDataPlansResponse>> {
  GetAllDataPlansNotifier();

  late GetAllDataPlansRepository _getAllDataPlansRepository;

  @override
  BaseState<GetDataPlansResponse> build() {
    _getAllDataPlansRepository = ref.read(getAllDataPlansRepositoryProvider);

    return BaseState<GetDataPlansResponse>.initial();
  }

  Future<void> getAllDataPlans() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _getAllDataPlansRepository.getAllDataPlans();

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getAllDataPlansNotifierProvider = NotifierProvider.autoDispose<
    GetAllDataPlansNotifier,
    BaseState<GetDataPlansResponse>>(GetAllDataPlansNotifier.new);
