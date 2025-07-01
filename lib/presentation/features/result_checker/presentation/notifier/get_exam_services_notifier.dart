import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/get_all_exams_model.dart';
import 'package:mapsdata/presentation/features/result_checker/data/repository/get_result_services_repo.dart';

class GetExamServicesNotifier
    extends AutoDisposeNotifier<BaseState<ExamResponse>> {
  GetExamServicesNotifier();

  late GetResultServicesRepository _repository;

  @override
  BaseState<ExamResponse> build() {
    _repository = ref.read(getResultServicesRepositoryProvider);

    return BaseState<ExamResponse>.initial();
  }

  Future<void> getResultServices() async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.getResultServices();

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }
}

final getResultServicesNotifierProvider = NotifierProvider.autoDispose<
    GetExamServicesNotifier,
    BaseState<ExamResponse>>(GetExamServicesNotifier.new);
