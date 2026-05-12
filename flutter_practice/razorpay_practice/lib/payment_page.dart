import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'razorpay_web.dart' hide Razorpay;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();

    // Only initialize Razorpay plugin on mobile
    if (!kIsWeb) {
      _razorpay = Razorpay();

      _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

      _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

      _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    }
  }

  void openCheckout() {
    // WEB
    if (kIsWeb) {
      RazorpayWeb.open(
        key: 'rzp_test_SmQYvGMI2YaSdd',
        amount: 50000,
        name: 'My Flutter App',
        description: 'Payment for Order',

        onSuccess: (paymentId) {
          debugPrint("WEB SUCCESS: $paymentId");

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Payment Successful")));
        },

        onError: (error) {
          debugPrint("WEB ERROR: $error");

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Payment Failed")));
        },
      );

      return;
    }

    // MOBILE
    var options = {
      'key': 'rzp_test_SmQYvGMI2YaSdd',
      'amount': 50000,
      'name': 'My Flutter App',
      'description': 'Payment for Order',

      'prefill': {'contact': '9876543210', 'email': 'test@example.com'},

      // payment methods
      'method': {'upi': true, 'card': true, 'netbanking': true, 'wallet': true},

      // only real wallets here
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("SUCCESS: ${response.paymentId}");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Payment Successful")));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("ERROR: ${response.code} - ${response.message}");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Payment Failed")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("EXTERNAL WALLET: ${response.walletName}");
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      _razorpay?.clear();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Razorpay Flutter")),

      body: Center(
        child: ElevatedButton(
          onPressed: openCheckout,
          child: const Text("Pay ₹500"),
        ),
      ),
    );
  }
}
