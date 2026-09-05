class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'نقابة الصحفيين  ';
  static const String appSubtitle = 'البوابة الرسمية للصحفيين والأعضاء';

    // API Endpoints
  static const String apiVersion = 'v1';

  // Pagination
  static const int pageSize = 20;

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Local Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserRole = 'user_role';
  static const String keyIsFirstLaunch = 'is_first_launch';



  // Routes
  static const String routeSplash = '/';
  static const String routeWelcome = '/welcome';
  static const String routeAdminLogin = '/admin-login';
  static const String routeEmployeeLogin = '/user-login';
  static const String routeAdminDashboard = '/admin-dashboard';
  static const String routeMembershipRequest = '/membership-request';
  static const String routeUserHome = '/user-home';
  static const String routeNewsDetails = 'news-details';
  static const String routeUserUpdateData = '/update-data';
  static const String routeTerm = '/term';
  static const String routePrivacy = '/privacy';
  static const String routeAboutApp = '/about-app';
  static const String routeAboutDeveloper = '/about-developer';

  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleJournalist = 'journalist';

  // File Upload
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'pdf'];

  // Form Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;

  // Membership Request Status
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'dd/MM/yyyy';
}
