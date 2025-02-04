import 'package:flutter/material.dart';
import 'package:stripe_payment_projectssss/payment_controller.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
var obj = PaymentController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:ElevatedButton(onPressed: (){
          obj.makePayment(amount: '5', currency: 'USD');
        }, child: Text("Make a Payment")),
      ),
    );
  }
}