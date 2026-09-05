
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/admin_stats_model.dart';

class AdminDashboardRepository {
  final SupabaseClient _supabase;

  AdminDashboardRepository(this._supabase);

  /// جلب إحصائيات لوحة التحكم بالتوازي لأداء سريع جداً
  Future<AdminStatsModel> fetchDashboardStats() async {
    try {
      final results = await Future.wait([
        _supabase.from('members').select('id').count(CountOption.exact),
        _supabase.from('members').select('id').eq('membership_type', 'permanent').count(CountOption.exact),
        _supabase.from('members').select('id').eq('membership_type', 'temporary').count(CountOption.exact),
        _supabase.from('membership_requests').select('id').eq('status', 'pending').count(CountOption.exact),
        _supabase.from('news').select('id').count(CountOption.exact),
        _supabase.from('tickets').select('id').eq('ticket_type', 'inquiry').eq('status', 'pending').count(CountOption.exact),
        _supabase.from('tickets').select('id').eq('ticket_type', 'complaint').eq('status', 'pending').count(CountOption.exact),      ]);

      return AdminStatsModel(
        totalMembers: results[0].count,
        permanentMembers: results[1].count,
        temporaryMembers: results[2].count,
        pendingRequests: results[3].count,
        totalNews: results[4].count,
        pendingInquiries: results[5].count,
        pendingComplaints: results[6].count,
      );
    } catch (e) {
      throw Exception('فشل في جلب البيانات');
    }
  }
}