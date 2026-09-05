import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pjs_portal/core/init/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/logic/auth_cubit.dart';
import '../../firebase_options.dart';
import '../di/injection.dart';
import '../service/notification_service.dart';
import '../session/user_session.dart';

class AppBootstrap {
  static Future<void> init() async {
    // تهيئة الـ Widgets
    WidgetsFlutterBinding.ensureInitialized();


    // تهيئة الخدمات الخارجية
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler,
    );

    await SupabaseConfig.initialize();
    await initializeDependencies(); // الـ Service Locator (sl)

    // إعدادات الواجهة واللغة
    _setupUI();
    await initializeDateFormatting("ar", null);

    try {
      await sl<AuthCubit>()
          .checkAuthState()
          .timeout(const Duration(seconds: 8));
    } catch (e) {
      debugPrint('⚠️ Auth check failed: $e');
    }

    // ✅ 5. Notifications بعد Auth — لأنها تحتاج UserSession
    try {
      await NotificationService.initialize()
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      debugPrint('⚠️ Notifications init failed: $e');
    }

    // 6. Auth listener
    _setupAuthListener();
  }

  static void _setupUI() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.tokenRefreshed && session != null) {
        if (UserSession.instance.isLoaded) {
          NotificationService.saveToken();
        }
      }

      if (event == AuthChangeEvent.signedOut) {
        UserSession.instance.clear();
        sl<AuthCubit>().forceSignedOut();
      }
    });
  }
}