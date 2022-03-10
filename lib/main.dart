import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:kum_kum/Pages/spash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kum_kum/repository/user_repository.dart' as userRepo;

void main()  {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      )
  );
  runApp(ProviderScope(child: MyApp()));
}
class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    userRepo.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kumkum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: GoogleFonts.zenKakuGothicAntique(fontWeight: FontWeight.w500).fontFamily,
      ),
      home: SplashScreen(),
    );
  }
}


