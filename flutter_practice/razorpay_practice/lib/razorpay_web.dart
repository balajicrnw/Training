import 'dart:js_interop';
import 'package:flutter/foundation.dart';

@JS('Razorpay')
extension type Razorpay(JSObject _) implements JSObject {
  external void open();
}

@JS()
extension type RazorpayResponse(JSObject _) implements JSObject {
  @JS('razorpay_payment_id')
  external String get razorpay_payment_id;
}

class RazorpayWeb {
  static void open({
    required String key,
    required int amount,
    required String name,
    required String description,
    required Function(String paymentId) onSuccess,
    required Function(String error) onError,
  }) {
    // The "newer way": use .toJS instead of allowInterop
    final handler = ((RazorpayResponse response) {
      onSuccess(response.razorpay_payment_id);
    }).toJS;

    final dismissHandler = (() {
      onError("Payment Cancelled");
    }).toJS;

    final options =
        {
              'key': key,
              'amount':
                  amount, // Assuming amount is already in paise from caller, or adjust if needed
              'name': name,
              'description': description,
              'handler': handler,
              'modal': {'ondismiss': dismissHandler},
              'prefill': {'contact': '9876543210', 'email': 'test@example.com'},
              'theme': {'color': '#3399cc'},
            }.jsify()
            as JSObject;

    try {
      final razorpay = Razorpay(options);
      razorpay.open();
    } catch (e) {
      debugPrint("Razorpay Web Error: $e");
      onError(e.toString());
    }
  }
}
