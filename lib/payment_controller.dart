import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentController {
  Map<String,dynamic>? paymentIntentData;

  Future<void> makePayment({required String amount, required String currency}) async{

    try{
      paymentIntentData = await createPaymentIntent(amount,currency);
      if(paymentIntentData != null){
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              merchantDisplayName: 'Prospects',
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralkey'],
            ));
        displayPaymentSheet();
      }
    }catch(e,s){
      print('exception: $e$s');
    }

  }

  displayPaymentSheet() async{
    try{
      await Stripe.instance.presentPaymentSheet();
      print('Payment Successful');
    } on Exception catch (e){
      if (e is StripeException){
        print("Error from Stripe: ${e.error.localizedMessage}");
      }else{
        print("Unforeseen error: ${e}");
      }
    }catch(e){
      print("exception: $e");
    }
  }


  createPaymentIntent(String amount, String currency)async{
    try{
      Map<String,dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response =  await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
            'Authorization':'Bearer sk_test_51QoijKPKZt2FG9pERx6PDsqW955L6GYPBfYrUJH0wHhNY7boCsHcr2mXJsMjzIwBUWvAeqpGej5VXtVZ3FfHuHvn00TafHnRp0',
          'Content-Type':' application/x-www-form-urlencoded'

        });
      return jsonDecode(response.body);
    }catch(err){
      print('err charging user : ${err.toString()}');
    }
  }
  calculateAmount(String amount){
    final a = (int.parse(amount))*100;
    return a.toString();
  }


}