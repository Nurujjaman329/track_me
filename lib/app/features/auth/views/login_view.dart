import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../models/login_request_model.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(controller: usernameController, decoration: const InputDecoration(labelText: 'Username')),
                  TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.loginUser(LoginRequestModel(
                        username: usernameController.text,
                        password: passwordController.text,
                      ));
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            )),
    );
  }
}
