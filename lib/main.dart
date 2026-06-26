import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/services/block_observer.dart';
import 'package:mirror_original/core/services/cache_helper.dart';
import 'package:mirror_original/features/auth/view_model/auth_cubit.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/splash/view/splash_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()..getProducts()..getCart()..getCategories()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
          ),
        ),
        home: SplashPage(),
      ),
    );
  }
}

// lib/
// │
// ├── core/
// │   ├── services/
// │   ├── theme/
// │   ├── utils/
// │   └── widgets/
// │
// ├── features/
// │   │
// │   ├── auth/
// │   │   ├── model/
// │   │   ├── view/
// │   │   ├── view_model/
// │   │   └── widgets/
// │   │
// │   ├── home/
// │   │   ├── model/
// │   │   ├── view/
// │   │   ├── view_model/
// │   │   └── widgets/
// │   │
// │   ├── cart/
// │   │   ├── view/
// │   │   ├── view_model/
// │   │   └── widgets/
// │   │
// │   └── profile/
// │       ├── view/
// │       ├── view_model/
// │       └── widgets/
// │
// └── main.dart

