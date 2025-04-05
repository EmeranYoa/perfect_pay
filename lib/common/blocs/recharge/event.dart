import '../../utils/type.dart';

abstract class RechargeEvent {}

class SelectRechargeMethod extends RechargeEvent {
  final RechargeMethod method;

  SelectRechargeMethod(this.method);
}

class NextStepEvent extends RechargeEvent {}

class PreviousStepEvent extends RechargeEvent {}

class PaymentMethodChosen extends RechargeEvent {
  final RechargeMethod method;

  PaymentMethodChosen(this.method);
}

class AmountEntered extends RechargeEvent {
  final int amount;

  AmountEntered(this.amount);
}

class CodePinEntered extends RechargeEvent {
  final String pin;

  CodePinEntered(this.pin);
}

// Final submission (if needed)
class SubmitRecharge extends RechargeEvent {}

class RechargeError extends RechargeEvent {}

class RechargeSuccess extends RechargeEvent {}

class ClearRechargeMethod extends RechargeEvent {}
