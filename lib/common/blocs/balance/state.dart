import 'package:equatable/equatable.dart';

class BalanceState extends Equatable {
  final double balance;
  final bool isLoading;
  final String? currency;
  final String? error;

  const BalanceState({
    this.balance = 0.0,
    this.isLoading = false,
    this.currency = 'USD',
    this.error,
  });

  // Helper to create a copy with new values
  BalanceState copyWith({
    double? balance,
    String? currency,
    bool? isLoading,
    String? error,
  }) {
    return BalanceState(
      balance: balance ?? this.balance,
      isLoading: isLoading ?? this.isLoading,
      currency: currency ?? this.currency,
      error: error,
    );
  }

  @override
  List<Object?> get props => [balance, currency, isLoading, error];
}
