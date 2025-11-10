import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  final usernameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: usernameC, decoration: InputDecoration(labelText: 'Username')),
          TextField(controller: emailC, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: passwordC, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          const SizedBox(height: 16),
          Obx(() => ElevatedButton(
            onPressed: auth.isLoading.value ? null : () {
              auth.register(usernameC.text.trim(), emailC.text.trim(), passwordC.text.trim());
            },
            child: auth.isLoading.value ? CircularProgressIndicator() : Text('Register'),
          )),
        ]),
      ),
    );
  }
}
