import 'dart:async';

import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:rxdart/rxdart.dart';

class Ticker {
  Stream<NewRequestNumbers> getNumberOfNewRequestesAsStream() {
    return MergeStream(
      [
        Stream.fromFuture(ApiOfferService().getNumberOfNewRequests()),
        Stream.periodic(
          const Duration(seconds: 5),
          (_) => ApiOfferService().getNumberOfNewRequests(),
        ).asyncMap((event) async => await event),
      ],
    );
  }
}
