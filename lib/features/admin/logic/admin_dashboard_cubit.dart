import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../data/repositories/admin_dashboard_repository.dart';
import 'admin_dashboard_state.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  final AdminDashboardRepository _repository;
  AdminDashboardCubit(this._repository) : super(AdminDashboardInitial());

  Future<void> loadDashboardStats() async {
    try {
      emit(AdminDashboardLoading());
      final stats = await _repository.fetchDashboardStats();
      emit(AdminDashboardLoaded(stats));
    } catch (e) {
      emit(AdminDashboardError(ErrorHandler.getReadableMessage(e)));
    }
  }
}