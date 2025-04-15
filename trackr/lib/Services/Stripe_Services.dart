import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:trackr/Services/Constants.dart';

class StripeService {
  StripeService._privateConstructor();

  static final StripeService instance = StripeService._privateConstructor();

  Future<void> makePayment(int amount) async {
    try {
      final clientSecret = await _createPaymentIntent(amount, 'pkr');
      if (clientSecret == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your App',
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {'amount': (amount * 100).toString(), 'currency': currency},
      );

      return response.data['client_secret'];
    } catch (e) {
      print('Error creating payment intent: $e');
      return null;
    }
  }
}
