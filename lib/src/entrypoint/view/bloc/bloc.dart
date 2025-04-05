import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<BottomNavItemSelected>(_onNavItemSelected);
  }

  void _onNavItemSelected(
    BottomNavItemSelected event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));
  }
}
