import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../models/register_request_model.dart';

class RegisterView extends StatelessWidget {
  final AuthController controller = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(controller: usernameController, decoration: const InputDecoration(labelText: 'Username')),
                  TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                  TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.registerUser(RegisterRequestModel(
                        username: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ));
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            )),
    );
  }
}
