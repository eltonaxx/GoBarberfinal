import 'package:GoBarber/routes/app_routes.dart';
import 'package:GoBarber/views/user_form.dart';
import 'package:GoBarber/views/user_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        AppRoutes.HOME: (_) => BuildListView(),
        AppRoutes.USER_FROM: (_) => UserForm()
      },
    );
  }
}
