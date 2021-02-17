part of 'offer_bloc.dart';

abstract class OfferState extends Equatable {
  const OfferState({this.count});

  final NewRequestNumbers count;

  @override
  List<Object> get props => [count];
}

class OfferInitial extends OfferState {}

class OfferTickSuccess extends OfferState {
  OfferTickSuccess({count}) : super(count: count);

  @override
  List<Object> get props => [count];
}
