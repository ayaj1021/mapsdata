import 'package:json_annotation/json_annotation.dart';

enum LoadState { loading, idle, success, error, loadmore, done }

enum LoginLoadState { loading, idle, success, error, unverified }

enum CurrentState { loggedIn, onboarded, initial }

enum OverLayType { loader, message, none, toast}

enum MessageType { error, success }

enum OtpType { email, phone }


enum BiometricDataType { password, pin }

enum Gender { MALE, FEMALE }

enum Currency { NGN, USD }

@JsonEnum()
enum ReferenceType {
  airtime,
  deposit,
  data,
  withdrawal,
  @JsonValue('cable-tv')
  cable,
  electricity,
}

@JsonEnum()
enum TransactionType { credit, debit }

@JsonEnum()
enum TransactionStatus { successful, pending, failed }

extension LoadExtension on LoadState {
  bool get isLoading => this == LoadState.loading;
  bool get isLoaded => this == LoadState.success;
  bool get isError => this == LoadState.error;
  bool get isInitial => this == LoadState.idle;
  bool get isLoadMore => this == LoadState.loadmore;
  bool get isCompleted => this == LoadState.done;
}

enum BillType {
  airtime(name: 'airtime'),
  data(name: 'data'),
  electricity(name: 'electricity'),
  cable(name: 'cable-tv');

  const BillType({
    required this.name,
  });
  final String name;
}

enum ActivityStatus { inApp, loggedOut }
