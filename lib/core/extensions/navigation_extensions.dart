import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension NavigationExtensions on BuildContext {

  Future<T?> pushWithCubit<T, C extends StateStreamableSource<Object?>>(
      C cubit,
      Widget screen,
      ) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: screen,
        ),
      ),
    );
  }

  Future<T?> pushWithCubits<T>(
      List<BlocProvider> providers,
      Widget screen,
      ) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: providers,
          child: screen,
        ),
      ),
    );
  }
}