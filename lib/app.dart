import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/dependencies.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/auth_gate.dart';
import 'features/categories/presentation/cubit/categories_cubit.dart';
import 'features/licenses/presentation/cubit/licenses_cubit.dart';
import 'features/questions/presentation/cubit/questions_cubit.dart';
import 'features/shell/presentation/cubit/shell_cubit.dart';

/// Root widget of the admin app.
///
/// Session-wide cubits are singletons provided above [MaterialApp], so pushed
/// editor routes see them too. They are reset on sign-out.
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  /// Below this width the UI scales from the students' 390-wide phone design;
  /// from it up, sizes are 1:1 so desktop web isn't blown up ~3.7×.
  static bool _scaleForPhone() => ScreenUtil().screenWidth < AdminTokens.phoneScaleBreakpoint;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleWH: _scaleForPhone,
      enableScaleText: _scaleForPhone,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>.value(value: getIt<AuthCubit>()),
            BlocProvider<ShellCubit>.value(value: getIt<ShellCubit>()),
            BlocProvider<LicensesCubit>.value(value: getIt<LicensesCubit>()),
            BlocProvider<CategoriesCubit>.value(value: getIt<CategoriesCubit>()),
            BlocProvider<QuestionsCubit>.value(value: getIt<QuestionsCubit>()),
          ],
          child: BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                previous.status == AuthStatus.admin && current.status != AuthStatus.admin,
            listener: (context, state) {
              context.read<ShellCubit>().reset();
              context.read<LicensesCubit>().reset();
              context.read<CategoriesCubit>().reset();
              context.read<QuestionsCubit>().reset();
            },
            child: MaterialApp(
              title: 'لوحة إدارة البشائر',
              debugShowCheckedModeBanner: false,

              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              theme: AppTheme.lightTheme,
              builder: (context, child) {
                // OS font scaling helps readability but must not break dense rows.
                final mediaQuery = MediaQuery.of(context);
                final scaled = MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: mediaQuery.textScaler.clamp(
                      minScaleFactor: 0.9,
                      maxScaleFactor: 1.3,
                    ),
                  ),
                  child: child!,
                );
                return BotToastInit()(context, scaled);
              },
              navigatorObservers: [BotToastNavigatorObserver()],
              home: const AuthGate(),
            ),
          ),
        );
      },
    );
  }
}
