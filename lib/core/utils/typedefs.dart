
import 'package:mapsdata/core/utils/enums.dart';

typedef MessageText = ({String title, String message, MessageType messageType});

typedef OrderConfirmArgs = ({
  List<({String title, String subtitle})> items,
  String amount,
  void Function(String v, bool save) onCompleted,
});
