import 'package:flutter_bloc/flutter_bloc.dart';

part 'jsap_event.dart';
part 'jsap_state.dart';

class JsapBloc extends Bloc<JsapEvent, JsapState> {
  JsapBloc() : super(JsapInitial()) {
    on<ChangeDelayEvent>((event, emit) {
      emit(
        DelayChangingSuccessful(
          event.delay,
        ),
      );
    });

    on<CreateNewClientEvent>((event, emit) {
      emit(CreationClientInitialState());
    });
    on<AssociatClientEvent>((event, emit) {
      emit(
        CreationClientSuccessfulState(),
      );
    });

    on<QuantityAddEvent>((event, emit){
      emit(QuantityState(quantity: event.lastQuantity + 1,),);
    });

    on<QuantityRemoveEvent>((event, emit){
      emit(QuantityState(quantity: (event.lastQuantity <= 1 )? event.lastQuantity : event.lastQuantity - 1,),);
    });

    on<SeeMoreCrEvent>((event, emit) {
      emit(
        SeeMoreState(isSeeMore: event.isSeeMore)
      );
    });

    on<ChangeBillingEvent>((event, emit) {
      emit(ChangeBillingState(billing: event.billing,),);
    } );

  }
}
