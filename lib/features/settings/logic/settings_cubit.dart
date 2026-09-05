import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pjs_portal/features/settings/logic/settings_state.dart';

import '../../../core/errors/error_handler.dart';
import '../../../core/session/user_session.dart';
import '../../members/data/model/member_model.dart';
import '../data/settings_repository.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

  SettingsCubit(this.repository) : super(SettingsInitial());

  Future<void> loadInitialSettings() async {
    emit(SettingsLoading());
    try {
      final String userId = UserSession.instance.authId;
      final data = await repository.getMember(userId);
      if (data == null) {
        emit(SettingsError('لا توجد بيانات لهذا المستخدم في قاعدة البيانات'));
        return;
      }

      emit(SettingsLoaded(MemberModel.fromJson(data)));
    } catch (e) {
      emit(SettingsError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> getMemberDataForUpdate(String userId) async {
    final previousMember = state is SettingsLoaded
        ? (state as SettingsLoaded).member
        : null;
    emit(GetMemberDataLoading());
    try {
      final authId = UserSession.instance.authId;
      final data = await repository.getMember(authId);

      if (data == null) {
        emit(SettingsError('فشل جلب البيانات'));
        if (previousMember != null) emit(SettingsLoaded(previousMember));
        return;
      }
      final member = MemberModel.fromJson(data);
      emit(GetMemberDataSuccess(member));
    } catch (e) {
      emit(SettingsError('حدث خطأ أثناء جلب البيانات'));
      if (previousMember != null) emit(SettingsLoaded(previousMember));
    }
  }
}
