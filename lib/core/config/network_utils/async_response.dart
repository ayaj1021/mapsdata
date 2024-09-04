
import 'package:equatable/equatable.dart';
import 'package:mapsdata/core/utils/enums.dart';

class AsyncResponse<T> extends Equatable {
  const AsyncResponse._({
    required this.loadState,
    this.data,
    this.e,
    this.stackTrace,
  });
  final LoadState loadState;
  final T? data;
  final String? e;
  final StackTrace? stackTrace;

  static AsyncResponse<T> success<T>(T data) {
    return AsyncResponse._(loadState: LoadState.success, data: data);
  }

  static AsyncResponse<T> error<T>(String error, {T? data}) {
    return AsyncResponse._(
      loadState: LoadState.error,
      e: error,
      data: data,
    );
  }

  static AsyncResponse<T> loading<T>() {
    return const AsyncResponse._(loadState: LoadState.loading);
  }

  static AsyncResponse<T> fetchMore<T>(T data) {
    return AsyncResponse._(loadState: LoadState.loadmore, data: data);
  }

  static AsyncResponse<T> idle<T>() {
    return const AsyncResponse._(loadState: LoadState.idle);
  }

  bool get isLoading => loadState == LoadState.loading;
  bool get isFetchingMore => loadState == LoadState.loadmore;
  bool get isError => loadState == LoadState.error;
  bool get isDone => loadState == LoadState.done;
  bool get isIdle => loadState == LoadState.idle;
  bool get isSuccess => loadState == LoadState.success;
  bool get isRefreshing => false;
  bool get isReloading => false;

  R when<R>({
    required R Function(T data) data,
    required R Function(
      String error,
      StackTrace stackTrace,
    ) error,
    required R Function() loading,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
    bool skipError = false,
  }) {
    if (isLoading) {
      bool skip;
      if (isRefreshing) {
        skip = skipLoadingOnRefresh;
      } else if (isReloading) {
        skip = skipLoadingOnReload;
      } else {
        skip = false;
      }
      if (!skip) return loading();
    }

    if (isError && (!hasValue || !skipError)) {
      return error(this.e!, stackTrace!);
    }

    return data(requireValue);
  }

  bool get hasValue => data != null;
  T get requireValue {
    if (!hasValue) {
      throw StateError(
        'Tried to use value from an AsyncResponse that has no value.',
      );
    }
    return data!;
  }

  @override
  List<Object?> get props => [loadState, data, e, stackTrace];
}
