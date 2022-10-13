import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_flutter_udemy/src/pages/client/map/client_map_page.dart';
import 'package:uber_clone_flutter_udemy/src/pages/driver/map/diver_map_page.dart';
import 'package:uber_clone_flutter_udemy/src/pages/driver/register/driver_register_page.dart';
import 'package:uber_clone_flutter_udemy/src/pages/home/home_page.dart';
import 'package:uber_clone_flutter_udemy/src/pages/login/login_page.dart';
import 'package:uber_clone_flutter_udemy/src/pages/client/register/client_register_page.dart';
import 'package:uber_clone_flutter_udemy/src/utils/colors.dart' as utils;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);
  // const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Clone',
      initialRoute: 'home',
      theme: ThemeData(
        primarySwatch: createThemeSwatch(utils.Colors.ubberCloneColor),
        // primaryColor: utils.Colors.ubberCloneColor,
        fontFamily: 'NimbusSans',
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
      routes: {
        'home':(BuildContext context) => HomePage(),
        'login':(BuildContext context) => LoginPage(),
        'client/register':(BuildContext context) => ClientRegisterPage(),
        'driver/register':(BuildContext context) => DriverRegisterPage(),
        'driver/map':(BuildContext context) => DriverMapPage(),
        'client/map':(BuildContext context) => ClientMapPage(),
      },
    );
  }
}
// create theme swatch
MaterialColor createThemeSwatch(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}