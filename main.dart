import 'package:flutter/material.dart';
import 'App.dart';
import 'package:firebase_core/firebase_core.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyB_jtDkKK87GSjbPG7kK33nRyrIcbOkoDk",
  authDomain: "controle-mei-544f8.firebaseapp.com",
  projectId: "controle-mei-544f8",
  storageBucket: "controle-mei-544f8.firebasestorage.app",
  messagingSenderId: "752617920787",
  appId: "1:752617920787:web:3d195ee69a0cb5137762e6",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(const App());
}
