part of 'jsap_bloc.dart';

sealed class JsapState {}

final class JsapInitial extends JsapState {}

class DelayChangingSuccessful extends JsapState {
  final int newDelay;

  DelayChangingSuccessful(this.newDelay);
}

class CreationClientInitialState extends JsapState {}

class CreationClientSuccessfulState extends JsapState {}

class QuantityState extends JsapState {
  final int quantity;
  QuantityState({required this.quantity});
}

class SeeMoreState extends JsapState {
  final bool isSeeMore;

  SeeMoreState({required this.isSeeMore});
}

class ChangeBillingState extends JsapState {
  final int billing;

  ChangeBillingState({required this.billing});
}