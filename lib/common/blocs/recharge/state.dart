import '../../utils/type.dart';

class RechargeState {
  final bool isLoading;
  final PaymentStep currentStep;
  final RechargeMethod? selectedMethod;
  final int? amount;
  final String? codePin;

  const RechargeState({
    required this.currentStep,
    this.selectedMethod,
    this.amount,
    this.codePin,
    this.isLoading = false,
  });

  factory RechargeState.initial() => const RechargeState(
        currentStep: PaymentStep.method,
        selectedMethod: null,
        amount: null,
        codePin: null,
        isLoading: false,
      );

  RechargeState copyWith({
    PaymentStep? currentStep,
    RechargeMethod? selectedMethod,
    int? amount,
    String? codePin,
    bool? isLoading,
  }) {
    return RechargeState(
      currentStep: currentStep ?? this.currentStep,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      amount: amount ?? this.amount,
      codePin: codePin ?? this.codePin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
