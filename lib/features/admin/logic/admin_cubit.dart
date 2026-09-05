
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../members/data/model/member_model.dart';
import '../data/repositories/admin_members_repository.dart';
import 'admin_members_state.dart';

class AdminCubit extends Cubit<AdminMembersState> {
  final AdminMembersRepository _repository;

  AdminCubit(this._repository) : super(const AdminMembersInitial());

  // الاحتفاظ بالبيانات والفلتر الحالي داخل الـ Cubit كمرجع ثابت
  List<MemberModel> _allMembers = [];
  String _currentFilter = 'all';

  Future<void> loadMembers() async {
    try {
      emit(const AdminMembersLoading());
      _allMembers = await _repository.getAllMembers();
      _applyFilterAndEmit();
    } catch (e) {
      emit(AdminMembersError(ErrorHandler.getReadableMessage(e)));
    }
  }

  /// دالة ذكية تقوم بالتصفية وإطلاق الحالة الجديدة للـ UI مباشرة
  void updateFilter(String filter) {
    _currentFilter = filter;
    _applyFilterAndEmit();
  }

  void _applyFilterAndEmit() {
    final filtered = switch (_currentFilter) {
      'admin' => _allMembers.where((m) => m.role == 'admin').toList(),
      'permanent' => _allMembers.where((m) => m.membershipType == 'permanent').toList(),
      'temporary' => _allMembers.where((m) => m.membershipType == 'temporary').toList(),
      _ => List<MemberModel>.from(_allMembers),
    };

    emit(AdminMembersLoaded(
      allMembers: _allMembers,
      filteredMembers: filtered,
      currentFilter: _currentFilter,
    ));
  }

  Map<String, int> buildCounts() => {
    'all': _allMembers.length,
    'admin': _allMembers.where((m) => m.role == 'admin').length,
    'permanent': _allMembers.where((m) => m.membershipType == 'permanent').length,
    'temporary': _allMembers.where((m) => m.membershipType == 'temporary').length,
  };

  Future<void> deleteMember(String memberId, String authUserId) async {
    try {
      // إطلاق حالة تحميل الإجراء وليس تحميل الصفحة كاملة
      emit(const AdminMembersActionLoading());
      await _repository.deleteMember(memberId, authUserId);

      // تحديث محلي سريع للكاش بدلاً من جلب البيانات مجدداً من السيرفر (توفير كوتا وسرعة مذهلة)
      _allMembers.removeWhere((m) => m.id == memberId);

      emit(const AdminMembersActionSuccess('تم حذف العضو بنجاح'));
      _applyFilterAndEmit(); // إعادة بناء القائمة محلياً فوراً
    } catch (e) {
      emit(AdminMembersError(ErrorHandler.getReadableMessage(e)));
      _applyFilterAndEmit();
    }
  }

  Future<void> changeMemberRole({
    required String memberId,
    required String newRole,
  }) async {
    try {
      emit(const AdminMembersActionLoading());
      await _repository.changeMemberRole(memberId: memberId, newRole: newRole);

      // تحديث محلي في الكاش للكائن المعدل فوراً
      final index = _allMembers.indexWhere((m) => m.id == memberId);
      if (index != -1) {
        _allMembers[index] = _allMembers[index].copyWith(role: newRole);
      }

      emit(const AdminMembersActionSuccess('تم تغيير الصلاحية بنجاح'));
      _applyFilterAndEmit();
    } catch (e) {
      emit(AdminMembersError(ErrorHandler.getReadableMessage(e)));
      _applyFilterAndEmit();
    }
  }

  Future<void> changeMembershipType({
    required String memberId,
    required String newType,
  }) async {
    try {
      emit(const AdminMembersActionLoading());
      await _repository.changeMembershipType(memberId: memberId, newType: newType);

      // تحديث محلي في الكاش للكائن المعدل فوراً
      final index = _allMembers.indexWhere((m) => m.id == memberId);
      if (index != -1) {
        _allMembers[index] = _allMembers[index].copyWith(membershipType: newType);
      }

      emit(const AdminMembersActionSuccess('تم تغيير نوع العضوية بنجاح'));
      _applyFilterAndEmit();
    } catch (e) {
      emit(AdminMembersError(ErrorHandler.getReadableMessage(e)));
      _applyFilterAndEmit();
    }
  }
}