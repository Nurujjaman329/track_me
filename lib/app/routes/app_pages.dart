import 'package:get/get.dart';
import 'package:getx_practise/app/features/splash/views/splash_view.dart';
import '../features/auth/views/login_view.dart';
import '../features/auth/views/register_view.dart';
import '../features/notes/views/notes_list_view.dart';
import '../features/profile/views/profile_view.dart';

import '../features/auth/bindings/auth_binding.dart';
import '../features/notes/bindings/notes_binding.dart';
import '../features/profile/bindings/profile_binding.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => NotesListView(),
      binding: NotesBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
