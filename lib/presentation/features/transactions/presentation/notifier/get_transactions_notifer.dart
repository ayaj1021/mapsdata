import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsdata/core/config/base_state/base_state.dart';
import 'package:mapsdata/core/config/exception/message_exception.dart';
import 'package:mapsdata/core/utils/enums.dart';
import 'package:mapsdata/presentation/features/transactions/data/model/get_transactions_response.dart';
import 'package:mapsdata/presentation/features/transactions/data/repo/get_transactions_repo.dart';

// class GetTransactionsNotifier
//     extends AutoDisposeNotifier<BaseState<TransactionResponse>> {
//   GetTransactionsNotifier();

//   late final GetTransactionsRepository _repository;

//   @override
//   BaseState<TransactionResponse> build() {
//     _repository = ref.read(getTransactionsRepositoryProvider);
//     return BaseState<TransactionResponse>.initial();
//   }

//   Future<void> getTransactions({
//     required void Function(String message) onSuccess,
//     required void Function(String message) onError,
//   }) async {
//     state = state.copyWith(state: LoadState.loading);
//     try {
//       final value = await _repository.getTransactions();
//       if (value.status == 'failed') throw value.message.toException;

//       state = state.copyWith(state: LoadState.idle, data: value.data);
//       onSuccess('');
//     } catch (e) {
//       onError(e.toString());
//       state = state.copyWith(state: LoadState.idle);
//     }
//   }
// }

final getTransactionsNotifer = NotifierProvider.autoDispose<
    GetTransactionsNotifier, BaseState<TransactionResponse>>(
  GetTransactionsNotifier.new,
);

class GetTransactionsNotifier
    extends AutoDisposeNotifier<BaseState<TransactionResponse>> {
  GetTransactionsNotifier();

  late final GetTransactionsRepository _repository;
  int _currentPage = 1;
  bool _hasMore = true;
  final List<TransactionData> _allTransactions = [];

  @override
  BaseState<TransactionResponse> build() {
    _repository = ref.read(getTransactionsRepositoryProvider);
    return BaseState<TransactionResponse>.initial();
  }

  Future<void> getTransactions({
    int page = 1,
    int entries = 25,
    String? search,
  }) async {
    state = state.copyWith(state: LoadState.loading);
    try {
      final value = await _repository.getTransactions(
        page: page,
        entries: entries,
        search: search,
      );

      if (value.status == 'failed') throw value.message.toException;

      _currentPage = value.data?.currentPage ?? 1;
      _hasMore = (value.data?.to ?? 0) < (value.data?.total ?? 0);
      _allTransactions.clear();
      _allTransactions.addAll(value.data?.data ?? []);

      state = state.copyWith(
        state: LoadState.idle,
        data: value.data?.copyWith(data: _allTransactions),
      );
    } catch (e) {
      state = state.copyWith(state: LoadState.idle);
    }
  }

  Future<void> loadMore({
    required void Function(String message) onError,
  }) async {
    if (!_hasMore) return;

    final nextPage = _currentPage + 1;

    try {
      final value = await _repository.getTransactions(page: nextPage);
      if (value.status == 'failed') throw value.message.toException;

      final newData = value.data?.data ?? [];
      _currentPage = value.data?.currentPage ?? nextPage;
      _hasMore = (value.data?.to ?? 0) < (value.data?.total ?? 0);
      _allTransactions.addAll(newData);

      state = state.copyWith(
        data: value.data?.copyWith(data: _allTransactions),
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
}
