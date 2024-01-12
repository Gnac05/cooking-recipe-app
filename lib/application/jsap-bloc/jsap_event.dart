part of 'jsap_bloc.dart';

sealed class JsapEvent {}

class ChangeDelayEvent extends JsapEvent {
  final int delay;

  ChangeDelayEvent(this.delay);
}

class CreateNewClientEvent extends JsapEvent {}

class SaveClientEvent extends JsapEvent {}

class QuantityAddEvent extends JsapEvent {
  final int lastQuantity;

  QuantityAddEvent({required this.lastQuantity});
}

class QuantityRemoveEvent extends JsapEvent {
  final int lastQuantity;

  QuantityRemoveEvent({required this.lastQuantity});
}

class SeeMoreCrEvent extends JsapEvent {
  final bool isSeeMore;

  SeeMoreCrEvent({required this.isSeeMore});
}

class ChangeBillingEvent extends JsapEvent {
  final int billing;

  ChangeBillingEvent(this.billing);
}

class ContinueStepEvent extends JsapEvent {
  final int lastIndex;

  ContinueStepEvent({required this.lastIndex});
}

class CancelStepEvent extends JsapEvent {
  final int lastIndex;

  CancelStepEvent({required this.lastIndex});
}

class TapStepEvent extends JsapEvent {
  final int index;

  TapStepEvent({required this.index});
}
