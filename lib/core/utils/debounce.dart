import 'dart:async';

/// A utility class that helps prevent excessive function calls
/// by delaying execution until a specified timeout has elapsed.
///
/// Useful for search inputs to prevent API calls on every keystroke.
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

/// Type definition for void callbacks with no parameters
typedef VoidCallback = void Function();
