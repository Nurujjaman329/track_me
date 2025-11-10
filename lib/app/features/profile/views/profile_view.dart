import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.find();

   ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchProfile();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final profile = controller.profile.value;
        if (profile == null) return const Center(child: Text('No profile found'));
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username: ${profile.username}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Email: ${profile.email}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        );
      }),
    );
  }
}
