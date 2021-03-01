import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/ticker/ticker.dart';
import 'package:flexrent/logic/models/models.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc(this._ticker) : super(OfferInitial());

  final Ticker _ticker;
  StreamSubscription _subscription;

  @override
  Stream<OfferState> mapEventToState(
    OfferEvent event,
  ) async* {
    if (event is OfferTickerStarted) {
      await _subscription?.cancel();

      _subscription = _ticker
          .getNumberOfNewRequestesAsStream()
          .listen((tick) => add(_OfferTickerTicked(tick)));
    }
    if (event is _OfferTickerTicked) {
      yield OfferTickSuccess(count: event.tickCount);
    }

    if (event is OfferTickerStopped) {
      await _subscription?.cancel();
      yield OfferInitial();
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
