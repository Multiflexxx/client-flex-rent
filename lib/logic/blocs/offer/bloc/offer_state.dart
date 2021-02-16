part of 'offer_bloc.dart';

abstract class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

class OfferInitial extends OfferState {}

class OfferTickSuccess extends OfferState {
  final NewRequestNumbers count;

  OfferTickSuccess(this.count);

  @override
  List<Object> get props => [count];
}
