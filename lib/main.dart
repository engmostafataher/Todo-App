import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff808000),
          
        ),
        // textTheme: TextTheme(
        //   bodyMedium: TextStyle(color: Colors.white)
        // )
      ),
    );
  }
}
