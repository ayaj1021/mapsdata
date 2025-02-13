
import 'package:mapsdata/core/utils/enums.dart';

class BuyAirtimeNotiferState {
  BuyAirtimeNotiferState({
    required this.buyAirtimeState,

  });

  final LoadState buyAirtimeState;

  
  factory BuyAirtimeNotiferState.initial() {
    return BuyAirtimeNotiferState(
      buyAirtimeState: LoadState.idle,  
    
    );
  }
  BuyAirtimeNotiferState copyWith({
    LoadState? buyAirtimeState,

  }) {
    return BuyAirtimeNotiferState(
      buyAirtimeState: buyAirtimeState ?? this.buyAirtimeState,
     
    );
  }
}
