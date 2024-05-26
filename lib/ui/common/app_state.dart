class AppState {
  final int counter;
  final bool isLoggedIn;

  AppState({
    required this.counter,
    required this.isLoggedIn,
  });

  // A factory method to create an initial state.
  factory AppState.initial() {
    return AppState(
      counter: 0,
      isLoggedIn: false,
    );
  }

  // A method to copy the current state and update some fields.
  AppState copyWith({
    int? counter,
    bool? isLoggedIn,
  }) {
    return AppState(
      counter: counter ?? this.counter,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
