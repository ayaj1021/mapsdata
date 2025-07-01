import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/buy_exam_request.dart';
import 'package:mapsdata/presentation/features/result_checker/data/model/buy_exam_response.dart';
import 'package:mapsdata/presentation/features/result_checker/data/repository/buy_exam_repo.dart';

class BuyExamNotifier extends AutoDisposeNotifier<BaseState<BuyExamResponse>> {
  BuyExamNotifier();

  late BuyExamRepository _repository;

  @override
  BaseState<BuyExamResponse> build() {
    _repository = ref.read(buyExamRepositoryProvider);

    return BaseState<BuyExamResponse>.initial();
  }

  Future<void> buyExam({
    required BuyExamRequest request,
    required void Function(String message) onError,
    required void Function(String message) onSuccess,
  }) async {
    state = state.copyWith(state: LoadState.loading);

    try {
      final value = await _repository.buyExam(request);

      if (value.status == 'failed') throw value.message?.toException ?? '';

      state = state.copyWith(state: LoadState.idle, data: (value.data));
      onSuccess(value.message ?? '');
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
      onError(e.toString());
    }
  }
}

final buyExamNotifierProvider =
    NotifierProvider.autoDispose<BuyExamNotifier, BaseState<BuyExamResponse>>(
        BuyExamNotifier.new);
