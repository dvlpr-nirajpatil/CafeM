import 'package:cafem/consts/globals.dart';
import 'package:cafem/controllers/food_controller.dart';
import 'package:cafem/firebase_options.dart';
import 'package:cafem/views/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

enum Routes { splash, login, signup, home }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(CafeM());
}

class CafeM extends StatelessWidget {
  CafeM({super.key});

  GoRouter router = GoRouter(navigatorKey: navigatorKey, routes: [
    GoRoute(
      path: '/',
      name: Routes.home.name,
      builder: (context, state) => HomeScreen(),
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FoodController())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
