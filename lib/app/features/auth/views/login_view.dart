import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_me/app/core/utils/app_colors.dart';
import 'package:track_me/app/routes/app_routes.dart';
import '../controllers/auth_controller.dart';
import '../models/login_request_model.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: Obx(() => controller.isLoading.value
          ? _buildLoadingState(isDark)
          : _buildLoginForm(context, isDark)),
    );
  }

  Widget _buildLoadingState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 3,
                ),
                Icon(
                  Icons.note_alt_outlined,
                  color: AppColors.primary,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Signing you in...',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.darkTextLight : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 60),

            // App Logo/Icon
            _buildAppHeader(isDark),

            const SizedBox(height: 40),

            // Welcome Text
            _buildWelcomeText(isDark),

            const SizedBox(height: 40),

            // Login Form
            _buildLoginFormContent(context, isDark),

            const SizedBox(height: 30),

            // Login Button
            _buildLoginButton(context),

            const SizedBox(height: 20),

            // Additional Options
            _buildAdditionalOptions(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader(bool isDark) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.surface,
              shape: BoxShape.circle,
            ),
          ),
          Icon(
            Icons.note_alt_rounded,
            color: AppColors.primary,
            size: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(bool isDark) {
    return Column(
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkText : AppColors.text,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue to your notes',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.darkTextLight : AppColors.textLight,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginFormContent(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.border,
          width: 1,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Username Field
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username or Email',
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: isDark ? AppColors.darkBackground.withOpacity(0.5) : AppColors.background,
              ),
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.text,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Password Field
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                suffixIcon: Icon(
                  Icons.visibility_off_outlined,
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.border,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: isDark ? AppColors.darkBackground.withOpacity(0.5) : AppColors.background,
              ),
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.text,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add forgot password logic
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            controller.loginUser(LoginRequestModel(
              username: usernameController.text,
              password: passwordController.text,
            ));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: AppColors.primary.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalOptions(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: isDark ? AppColors.darkTextLight : AppColors.textLight,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.register);
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
