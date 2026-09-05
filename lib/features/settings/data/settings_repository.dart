import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsRepository {
  final SupabaseClient supabase;

  SettingsRepository(this.supabase);

  Future<Map<String, dynamic>?> getMember(String userId) async {
    return await supabase
        .from('members')
        .select('*, member_details(*)')
        .eq('id', userId)
        .maybeSingle();
  }
}