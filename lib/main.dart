import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tsr_admin/Pages/dashboard.dart';
import 'package:tsr_admin/Pages/employee_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyBaa7jCUwznF8GWAsgtXcoyNL5AYammHeA",
    projectId: "makingapi-69f83",
    messagingSenderId: "757240282447",
    appId: "1:757240282447:web:c4e9fd698eaef5958cd93a",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TSR admin',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // home: EmployeProfile(
      //   uid: "pGitJKAFZAhVxI2Xzzroowt0z2S2",
      //   countWeb: '12',
      //   countApp: '24',
      //   countDm: '85',
      //   countWebnDm: '642',
      //   countWebnApp: '54',
      //   countAppnDm: '45',
      //   countProfile: '10',
      //   countCallLater: '214',
      //   countNotIntersted: '56',
      //   countTotal: '45',
      // ),
       home: Dashboard(),
    );
  }
}
