class SwipeTracker {
  DateTime? _startTime;
  double? _startPosition;
  final List<Map<String, dynamic>> _swipeEvents = [];

  void startSwipe(double position) {
    _startTime = DateTime.now();
    _startPosition = position;
  }

  void endSwipe(double position) {
    if (_startTime == null || _startPosition == null) return;

    final now = DateTime.now();
    final duration = now.difference(_startTime!).inMilliseconds;
    final distance = (position - _startPosition!).abs();
    final speed = distance / (duration == 0 ? 1 : duration);

    _swipeEvents.add({
      'timestamp': now.toIso8601String(),
      'duration_ms': duration,
      'distance_px': distance,
      'speed_px_per_ms': speed,
    });

    _startTime = null;
    _startPosition = null;
  }

  List<Map<String, dynamic>> getSwipeEvents() => List.unmodifiable(_swipeEvents);

  void reset() => _swipeEvents.clear();
}
