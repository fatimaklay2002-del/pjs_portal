import '../../members/data/model/member_model.dart';
sealed class AdminMembersState {
  const AdminMembersState();
}

class AdminMembersInitial extends AdminMembersState {
  const AdminMembersInitial();
}

class AdminMembersLoading extends AdminMembersState {
  const AdminMembersLoading();
}

// تعديل الحالة لتشمل الأعضاء المفلترين والفلتر الحالي لتسهيل عمل الـ UI
class AdminMembersLoaded extends AdminMembersState {
  final List<MemberModel> allMembers;
  final List<MemberModel> filteredMembers;
  final String currentFilter;

  const AdminMembersLoaded({
    required this.allMembers,
    required this.filteredMembers,
    this.currentFilter = 'all',
  });
}

class AdminMembersError extends AdminMembersState {
  final String message;
  const AdminMembersError(this.message);
}

// حالة تحميل فرعية للإجراءات (حذف/تعديل) لكي لا نختفي بالقائمة بأكملها
class AdminMembersActionLoading extends AdminMembersState {
  const AdminMembersActionLoading();
}

class AdminMembersActionSuccess extends AdminMembersState {
  final String message;
  const AdminMembersActionSuccess(this.message);
}