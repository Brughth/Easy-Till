import 'package:auto_route/auto_route.dart';

import '../../application_screen.dart';
import '../../auth/presentation/Register_screen.dart';
import '../../auth/presentation/login_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: ApplicationRoute.page,
        ),
      ];
}
