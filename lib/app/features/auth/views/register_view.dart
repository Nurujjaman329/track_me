import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_me/app/core/utils/app_colors.dart';
import 'package:track_me/app/routes/app_routes.dart';
import '../controllers/auth_controller.dart';
import '../models/register_request_model.dart';

class RegisterView extends StatelessWidget {
  final AuthController controller = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? AppColors.darkText : AppColors.text,
      ),
      body: Obx(() => controller.isLoading.value
          ? _buildLoadingState(isDark)
          : _buildRegisterForm(context, isDark)),
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
                  Icons.note_add_outlined,
                  color: AppColors.primary,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Creating your account...',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? AppColors.darkTextLight : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // App Icon
            _buildAppIcon(isDark),

            const SizedBox(height: 30),

            // Welcome Text
            _buildWelcomeText(isDark),

            const SizedBox(height: 40),

            // Registration Form
            _buildRegisterFormContent(context, isDark),

            const SizedBox(height: 30),

            // Register Button
            _buildRegisterButton(context),

            const SizedBox(height: 20),

            // Login Option
            _buildLoginOption(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildAppIcon(bool isDark) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.note_add_rounded,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  Widget _buildWelcomeText(bool isDark) {
    return Column(
      children: [
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.darkText : AppColors.text,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Start organizing your notes with us',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.darkTextLight : AppColors.textLight,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegisterFormContent(BuildContext context, bool isDark) {
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
                labelText: 'Username',
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
                  return 'Please enter a username';
                }
                if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Email Field
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: isDark ? AppColors.darkTextLight : AppColors.textLight,
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
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
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
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
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Password Requirements
            _buildPasswordRequirements(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password must contain:',
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppColors.darkTextLight : AppColors.textLight,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 14,
              color: AppColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              'At least 6 characters',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? AppColors.darkTextLight : AppColors.textLight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            controller.registerUser(RegisterRequestModel(
              username: usernameController.text,
              email: emailController.text,
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
              'Create Account',
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

  Widget _buildLoginOption(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            color: isDark ? AppColors.darkTextLight : AppColors.textLight,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(AppRoutes.login);
          },
          child: Text(
            'Sign In',
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
