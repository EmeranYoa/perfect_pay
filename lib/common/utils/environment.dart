import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get apiKey {
    return dotenv.env['API_KEY'] ?? 'API_KEY not found';
  }

  static String get baseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'API_BASE_URL not found';
  }

  static String get tokenKey {
    return dotenv.env['TOKEN_KEY'] ?? 'TOKEN_KEY not found';
  }

  static String get isFirst {
    return dotenv.env['IS_FIRST'] ?? 'IS_FIRST not found';
  }

  static String get stripePublishableKey {
    return dotenv.env['STRIPE_PUBLISHABLE_KEY'] ??
        'STRIPE_PUBLISHABLE_KEY not found';
  }

  static String get appName {
    return dotenv.env['APP_NAME'] ?? 'APP_NAME not found';
  }
}
