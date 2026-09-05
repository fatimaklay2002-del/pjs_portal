import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart' as scheduler ;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/notification/data/model/notification_model.dart';
import '../../features/notification/logic/notifications_cubit.dart';
import '../../firebase_options.dart';
import '../di/injection.dart';
import '../navigation/app_navigator.dart';
import '../session/user_session.dart';
import '../navigation/notification_navigation.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

@pragma('vm:entry-point')
void _backgroundNotificationHandler(NotificationResponse details) {
  final payload = details.payload ?? '';
  final parts = payload.split('|');
  if (parts.isNotEmpty) {
    NotificationService._pendingNotificationType = parts[0];
    NotificationService._pendingReferenceId =
        parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null;
  }
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'pjs_high_importance',
    'إشعارات النقابة',
    description: 'إشعارات مهمة من نقابة الصحفيين',
    importance: Importance.max,
  );
  static Future<void> initialize() async {
    // ✅ لا تُسجّل هنا — مسجّل في AppBootstrap بالفعل
    // FirebaseMessaging.onBackgroundMessage(...)  ← احذف هذا من هنا

    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('🔔 Permission: ${settings.authorizationStatus}');

    // ✅ Channel أولاً
    await _localNotifications
        .resolvePlatformSpecificImplementation
        <AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // ✅ ثم initialize
    await _localNotifications.initialize(
      settings: InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_notification'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (details) {
        debugPrint('🔔 Tapped: ${details.payload}');
        final payload = details.payload ?? '';
        if (payload.isEmpty) return;
        final parts = payload.split('|');
        _pendingNotificationType = parts[0];
        _pendingReferenceId =
        parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null;
        final ctx = AppNavigator.context;
        if (ctx != null) handlePendingNavigation(ctx);
      },
      onDidReceiveBackgroundNotificationResponse:
      _backgroundNotificationHandler,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('🔔 Foreground: ${message.notification?.title}');
      _showLocalNotification(message);
    });

    _setupInteraction();

    // ✅ Token بعد كل شيء
    if (UserSession.instance.isLoaded) {
      await saveToken();
    }

    _messaging.onTokenRefresh.listen((newToken) {
      if (UserSession.instance.isLoaded) {
        _updateTokenInSupabase(newToken);
      }
    });
  }

  static void _setupInteraction() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageClick);

    // التطبيق مغلق تماماً ← نقر على الإشعار
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) _handleMessageClick(message);
    });
  }

  static void _handleMessageClick(RemoteMessage message) {
    final type = message.data['type'] ?? '';
    final referenceId = message.data['related_id'];

    // نحتاج context — نخزن الـ data ونعالجها بعد
    _pendingNotificationType = type;
    _pendingReferenceId = referenceId;

    debugPrint('Notification tapped: type=$type, id=$referenceId');
  }

  // متغيرات مؤقتة
  static String? _pendingNotificationType;
  static String? _pendingReferenceId;

  // استدعي هذه الدالة من أول شاشة تُبنى بعد Login
  static void handlePendingNavigation(BuildContext context) {
    final type = _pendingNotificationType;
    final id = _pendingReferenceId;

    if (type == null || type.isEmpty) return;

    // امسح بعد المعالجة
    _pendingNotificationType = null;
    _pendingReferenceId = null;

    // أنشئ NotificationModel وهمي للـ navigate
    final notification = NotificationModel(
      id: '',
      userId: '',
      title: '',
      body: '',
      type: type,
      relatedId: id,
      isRead: true,
      createdAt: DateTime.now(),
    );

    scheduler.SchedulerBinding.instance.addPostFrameCallback((_) {
      final ctx = AppNavigator.context;
      if (ctx == null) return;
      NotificationNavigation.navigate(ctx, notification);
    });
  }

  static Future<void> saveToken() async {
    try {
      if (!UserSession.instance.isLoaded) return;
      final token = await _messaging.getToken();
      if (token == null) return;
      await _updateTokenInSupabase(token);
      debugPrint('FCM Token saved ✅');
    } catch (e) {
      debugPrint('saveToken error: $e');
    }
  }

  static Future<void> _updateTokenInSupabase(String token) async {
    try {
      if (!UserSession.instance.isLoaded) return;
      final memberId = UserSession.instance.currentMember.id;
      await Supabase.instance.client
          .from('members')
          .update({'fcm_token': token})
          .eq('id', memberId);
    } catch (e) {
      debugPrint('_updateTokenInSupabase error: $e');
    }
  }


    static void _showLocalNotification(RemoteMessage message) {
      final notification = message.notification;
      if (notification == null) return;

      final id = message.hashCode.abs() % 100000;

      // ✅ positional parameters
      _localNotifications.show(
       id:id,
       title:  notification.title,
       body:  notification.body,
      notificationDetails:   NotificationDetails(
          android: AndroidNotificationDetails(
            'pjs_high_importance',
            'إشعارات النقابة',
            channelDescription: 'إشعارات مهمة من نقابة الصحفيين',
            importance: Importance.max,
            priority: Priority.high,
            category: AndroidNotificationCategory.message,
            visibility: NotificationVisibility.public,
            icon: '@mipmap/ic_notification',
            playSound: true,
            enableVibration: true,
            enableLights: true,
            fullScreenIntent: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: '${message.data['type']}|${message.data['related_id'] ?? ''}',
      );
    }

  static Future<void> onLogin() async {
    await saveToken();
    sl<NotificationsCubit>().loadAndSubscribe();
  }

  static Future<void> onLogout() async {
    try {
      if (!UserSession.instance.isLoaded) return;
      final memberId = UserSession.instance.currentMember.id;
      await Supabase.instance.client
          .from('members')
          .update({'fcm_token': null})
          .eq('id', memberId);
      sl<NotificationsCubit>().clear();
    } catch (e) {
      debugPrint('onLogout error: $e');
    }
  }
}
