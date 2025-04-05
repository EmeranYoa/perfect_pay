class NavigationState {
  final int currentIndex;

  const NavigationState({required this.currentIndex});

  factory NavigationState.initial() {
    return const NavigationState(currentIndex: 0);
  }

  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
