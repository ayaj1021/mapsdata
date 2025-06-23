import 'package:mapsdata/core/utils/enums.dart';

class BaseState<T> {
  const BaseState({
    required this.state,
    this.data,
    this.errorMessage,
  });

  final LoadState state;
  final T? data;
  final String? errorMessage;

  BaseState<T> copyWith({
    LoadState? state,
    T? data,
    String? errorMessage,
  }) {
    return BaseState<T>(
      state: state ?? this.state,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory BaseState.initial([T? data]) => BaseState<T>(
        state: LoadState.idle,
        data: data,
      );
}
