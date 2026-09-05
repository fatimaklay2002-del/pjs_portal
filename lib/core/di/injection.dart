import 'package:get_it/get_it.dart';
import 'package:pjs_portal/features/settings/data/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/admin/data/repositories/admin_dashboard_repository.dart';
import '../../features/admin/data/repositories/admin_members_repository.dart';
import '../../features/admin/data/repositories/admin_membership_repository.dart';
import '../../features/admin/logic/admin_cubit.dart';
import '../../features/admin/logic/admin_dashboard_cubit.dart';
import '../../features/admin/logic/admin_membership_cubit.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/logic/auth_cubit.dart';

import '../../features/members/data/repositores/member_repository.dart';
import '../../features/members/logic/member_cubit.dart';
import '../../features/membership/data/repositories/membership_repository.dart';
import '../../features/membership/logic/membership_cubit.dart';
import '../../features/news/data/repositories/news_repository.dart';
import '../../features/news/logic/news_cubit.dart';
import '../../features/notification/logic/notifications_cubit.dart';
import '../../features/settings/logic/settings_cubit.dart';
import '../../features/tickets/data/repositores/admin_inquiry_repository.dart';
import '../../features/tickets/data/repositores/inquiry_repository.dart';
import '../../features/tickets/logic/members/member_tickets_cubit.dart';
import '../../features/tickets/logic/admin/admin_tickets_cubit.dart';
import '../service/file_upload_service.dart';
import '../service/storage_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  final supabaseClient = Supabase.instance.client;
  sl.registerLazySingleton<SupabaseClient>(() => supabaseClient);
  _initCoreServices();
  // Features
  _initAuth();
  _initMembership();
  _initAdminDashboard();
  _initAdminMembersList();
  _initAdminMembership();
  _initNews();
  _initInquiries();
  _initMembers();
  _initAdminInquiries();
  _initSettings();
  _initNotifications();
}
void _initCoreServices() {
  sl.registerLazySingleton<StorageService>(
        () => StorageService(sl<SupabaseClient>()),
  );
  sl.registerLazySingleton<FileUploadService>(
        () => FileUploadService(sl<StorageService>()),
  );
}
/// Initialize Auth feature dependencies
void _initAuth() {
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepository(sl<SupabaseClient>()),
  );

  sl.registerLazySingleton<AuthCubit>(
        () => AuthCubit(sl<AuthRepository>()),
  );
}
void _initMembership() {
  sl.registerLazySingleton<MembershipRepository>(
        () => MembershipRepository(sl<SupabaseClient>()),
  );
  sl.registerFactory<MembershipCubit>(
        () => MembershipCubit(sl<MembershipRepository>(), sl<FileUploadService>()),
  );
}
void _initAdminDashboard() {
  // Repository
  sl.registerLazySingleton<AdminDashboardRepository>(
        () => AdminDashboardRepository(sl<SupabaseClient>()),
  );
  // Cubit
  sl.registerFactory<AdminDashboardCubit>(
        () => AdminDashboardCubit(sl<AdminDashboardRepository>()),
  );
}

/// 2. إدارة طلبات العضوية المعلقة والقبول/الرفض
void _initAdminMembership() {
  // Repository
  sl.registerLazySingleton<AdminMembershipRepository>(
        () => AdminMembershipRepository(sl<SupabaseClient>()),
  );
  // Cubit
  sl.registerFactory<AdminMembershipCubit>(
        () => AdminMembershipCubit(sl<AdminMembershipRepository>()),
  );
}

/// 3. إدارة الأعضاء الحاليين (حذف، تغيير رتبة، تعديل نوع عضوية)
void _initAdminMembersList() {
  // Repository
  sl.registerLazySingleton<AdminMembersRepository>(
        () => AdminMembersRepository(sl<SupabaseClient>()),
  );
  // Cubit (تأكدي من مطابقة اسم الكلاس للـ Cubit الخاص بكِ وهو AdminCubit)
  sl.registerFactory<AdminCubit>(
        () => AdminCubit(sl<AdminMembersRepository>()),
  );
}
void _initNews() {
  sl.registerLazySingleton<NewsRepository>(
        () => NewsRepository(sl<SupabaseClient>()),
  );
  sl.registerFactory<NewsCubit>(
        () => NewsCubit(sl<NewsRepository>()),
  );
}

void _initInquiries() {
  sl.registerLazySingleton<InquiryRepository>(
        () => InquiryRepository(sl<SupabaseClient>()),
  );
  sl.registerFactory<TicketsCubit>(
        () => TicketsCubit(sl<InquiryRepository>()),
  );
}
void _initAdminInquiries() {
  sl.registerLazySingleton<AdminTicketsRepository>(
        () => AdminTicketsRepository(sl<SupabaseClient>()),
  );
  sl.registerFactory<AdminTicketsCubit>(
        () => AdminTicketsCubit(sl<AdminTicketsRepository>()),
  );
}


void _initMembers() {
  sl.registerLazySingleton<MemberRepository>(
        () => MemberRepository(sl<SupabaseClient>()),
  );
  sl.registerFactory<MemberCubit>(
        () => MemberCubit(sl<MemberRepository>(), sl<FileUploadService>()),
  );
}


void _initSettings() {
  sl.registerLazySingleton<SettingsRepository>(
        () => SettingsRepository(sl<SupabaseClient>()),
  );
  sl.registerFactory<SettingsCubit>(
        () => SettingsCubit(sl<SettingsRepository>()),
  );
}
void _initNotifications() {
  sl.registerLazySingleton<NotificationsCubit>(
        () => NotificationsCubit(sl<SupabaseClient>()),
  );
}
