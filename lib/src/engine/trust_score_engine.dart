class TrustScoreEngine {
  int calculateScore(Map<String, dynamic> sessionData) {
    int score = 100;

    try {
      List<dynamic> taps = sessionData['tap_durations_ms'] ?? [];
      if (taps is List && taps.any((t) => t is int && t < 50)) {
        score -= 10;
      }

      List<dynamic> screens = sessionData['screens_visited'] ?? [];
      if (screens.length > 3 && screens[1]['screen'] == 'TransferTypePage') {
        score -= 20;
      }

      Map<String, dynamic> durations = Map<String, dynamic>.from(
          sessionData['screen_durations'] ?? {});
      durations.forEach((screen, seconds) {
        if (seconds is int && seconds < 2) score -= 5;
      });

      if (sessionData['screen_recording_detected'] == true) {
        score -= 25;
      }
    } catch (e) {
      print("⚠️ Scoring failed with error: $e");
      return 0;
    }

    return score.clamp(0, 100);
  }
}
