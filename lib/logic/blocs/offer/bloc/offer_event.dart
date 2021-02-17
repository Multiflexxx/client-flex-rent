part of 'offer_bloc.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class OfferTickerStarted extends OfferEvent {}

class _OfferTickerTicked extends OfferEvent {
  final NewRequestNumbers tickCount;

  const _OfferTickerTicked(this.tickCount);

  @override
  List<Object> get props => [tickCount];
}

class OfferTickerStopped extends OfferEvent {}
