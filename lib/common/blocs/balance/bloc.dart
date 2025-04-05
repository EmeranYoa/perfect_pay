import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_pay/common/services/http.dart';
import 'package:perfect_pay/common/utils/environment.dart';

import 'event.dart';
import 'state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(const BalanceState()) {
    on<GetBalance>(_onGetBalance);
  }

  Future<void> _onGetBalance(GetBalance event,
      Emitter<BalanceState> emit,) async {
    try {
      final httpService = await HttpService.create(
        baseUrl: Environment.baseUrl,
      );

      final response = await httpService.request(
        endpoint: "accounts/balance",
        method: "GET",
      );

      final responseData = jsonDecode(response.body);

      final balance = responseData['balance'];
      final currency = responseData['currency'];

      emit(state.copyWith(
          balance: balance, currency: currency, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load balance',
      ));
    }
  }
}
