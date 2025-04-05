import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_pay/common/utils/type.dart';

import 'event.dart';
import 'state.dart';

class RechargeBloc extends Bloc<RechargeEvent, RechargeState> {
  RechargeBloc() : super(RechargeState.initial()) {
    on<PaymentMethodChosen>((event, emit) {
      emit(state.copyWith(selectedMethod: event.method));
    });

    on<AmountEntered>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });

    on<CodePinEntered>((event, emit) {
      emit(state.copyWith(codePin: event.pin));
    });

    on<NextStepEvent>((event, emit) {
      switch (state.currentStep) {
        case PaymentStep.method:
          emit(state.copyWith(currentStep: PaymentStep.amount));
          break;
        case PaymentStep.amount:
          emit(state.copyWith(currentStep: PaymentStep.pin));
          break;
        case PaymentStep.pin:
          break;
      }
    });

    on<PreviousStepEvent>((event, emit) {
      switch (state.currentStep) {
        case PaymentStep.method:
          break;
        case PaymentStep.amount:
          emit(state.copyWith(currentStep: PaymentStep.method));
          break;
        case PaymentStep.pin:
          emit(state.copyWith(currentStep: PaymentStep.amount));
          break;
      }
    });

    on<SubmitRecharge>((event, emit) {
      emit(state.copyWith(isLoading: true));
    });

    on<RechargeError>((event, emit) {
      emit(state.copyWith(isLoading: false));
      emit(RechargeState.initial());
    });

    on<RechargeSuccess>((event, emit) {
      emit(state.copyWith(isLoading: false));
      ;
    });

    on<ClearRechargeMethod>((event, emit) {
      emit(RechargeState.initial());
    });
  }
}
