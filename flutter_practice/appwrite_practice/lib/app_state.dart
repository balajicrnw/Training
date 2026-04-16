import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;


class MyApp extends StatefulWidget {
  final Account account;

  const MyApp({super.key, required this.account});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  models.User? loggedInUser;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String? userId;
  bool otpSent = false;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  // 🔍 Check session
  Future<void> checkUser() async {
    try {
      final user = await widget.account.get();
      setState(() {
        loggedInUser = user;
      });
    } catch (_) {}
  }

  // 📩 Send OTP
  Future<void> sendOtp() async {
    try {
      final token = await widget.account.createPhoneToken(
        userId: ID.unique(),
        phone: phoneController.text,
      );

      userId = token.userId;

      setState(() {
        otpSent = true;
      });

      print("OTP Sent");
    } catch (e) {
      print("Send OTP Error: $e");
    }
  }

  // ✅ Verify OTP
  Future<void> verifyOtp() async {
    try {
      await widget.account.createSession(
        userId: userId!,
        secret: otpController.text,
      );

      final user = await widget.account.get();

      setState(() {
        loggedInUser = user;
      });

      print("Login Success");
    } catch (e) {
      print("OTP Verify Error: $e");
    }
  }

  // 🚪 Logout
  Future<void> logout() async {
    await widget.account.deleteSession(sessionId: 'current');

    setState(() {
      loggedInUser = null;
      otpSent = false;
      phoneController.clear();
      otpController.clear();
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Phone OTP Login")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: loggedInUser == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: "Phone (+91xxxxxxxxxx)",
                      ),
                    ),
                    const SizedBox(height: 10),

                    if (!otpSent)
                      ElevatedButton(
                        onPressed: sendOtp,
                        child: const Text("Send OTP"),
                      ),

                    if (otpSent) ...[
                      TextField(
                        controller: otpController,
                        decoration: const InputDecoration(
                          labelText: "Enter OTP",
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: verifyOtp,
                        child: const Text("Verify & Login"),
                      ),
                    ],
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Logged in! User ID: ${loggedInUser!.$id}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: logout,
                      child: const Text("Logout"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}