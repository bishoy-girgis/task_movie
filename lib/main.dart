import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Core/config/page_route_name.dart';
import 'Core/config/routes.dart';
import 'Core/config/theme.dart';
import 'Core/services/bloc_observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            initialRoute: PageRouteName.home,
            onGenerateRoute: Routes.generateRoute,
          );
        });
  }
}
