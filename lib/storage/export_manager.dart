import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ExportManager {
  Future<void> exportToJson(Map<String, dynamic> data, String baseFileName) async {
    try {
      final timestamp = DateTime.now().toIso8601String().replaceAll(":", "-");
      final fileName = '$baseFileName\_$timestamp.json';

      // ✅ Write to visible Downloads/PhishSafe folder
      final directory = Directory('/sdcard/Download/PhishSafe');
      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }

      final file = File('${directory.path}/$fileName');
      final jsonData = const JsonEncoder.withIndent('  ').convert(data);
      await file.writeAsString(jsonData);

      print('✅ Saved to visible folder: ${file.path}');
    } catch (e) {
      print('❌ Failed to export or open session data: $e');
    }
  }
  Future<void> exportUserProfile(Map<String, dynamic> data, String fileName) async {
    try {
      final directory = Directory('/sdcard/Download/PhishSafe');
      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }

      final file = File('${directory.path}/$fileName');
      final jsonData = const JsonEncoder.withIndent('  ').convert(data);
      await file.writeAsString(jsonData);

      print('✅ User profile saved silently to: ${file.path}');
    } catch (e) {
      print('❌ Failed to export user profile: $e');
    }
  }

}