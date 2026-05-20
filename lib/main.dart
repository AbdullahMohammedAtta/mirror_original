import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirror_original/core/utils/block_observer.dart';
import 'package:mirror_original/features/home/view_model/home_cubit.dart';
import 'package:mirror_original/features/splash/view/splash_page.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.black),
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

