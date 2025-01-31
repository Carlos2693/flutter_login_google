import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String keyAuthGoogle = dotenv.env['AUTH_GOOGLE_KEY'] ?? '';
  static String apiId = dotenv.env['APP_ID'] ?? '';
  static String messagingSenderId = dotenv.env['MESSAGING_SEND_ID'] ?? '';
  static String projectId = dotenv.env['PROJECT_ID'] ?? '';
  static String storageBucket = dotenv.env['STORAGE_BUCKET'] ?? '';
}
