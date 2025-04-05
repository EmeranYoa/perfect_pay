abstract class NavigationEvent {}

class BottomNavItemSelected extends NavigationEvent {
  final int index;

  BottomNavItemSelected(this.index);
}
