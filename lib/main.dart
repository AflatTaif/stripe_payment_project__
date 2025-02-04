import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'home.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51QoijKPKZt2FG9pElP4q685RzXeG3nO9x4b5XYo23TmgrBazSd16bEZYN6E8kMztNBmSIcck71CcSWUEE26Nofzw00EmmUCQoj';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Flutter Demo',
      theme: ThemeData(

      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //
      home: const MyHomePage(title: 'Payment With Stripe'),
    );
  }
}