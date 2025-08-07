import 'package:flutter/material.dart';

import 'package:pose/screens/homeScreen.dart';




void main()  {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //
  //
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //
  //
  // await Future.delayed(Duration(seconds: 1));
  //
  //
  // FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player App',
        theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.white,
            secondary: Colors.grey,
          ),),
      home: Homescreen(),
    );
  }
}

