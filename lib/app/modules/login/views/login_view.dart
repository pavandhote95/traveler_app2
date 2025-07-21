import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/constants/custom_button.dart';
import 'package:travel_app2/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:travel_app2/app/modules/otp/views/otp_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF121212),
      body: AnimatedContainer(
        duration: const Duration(seconds: 3),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1B1B1B),
              Color(0xFF232526),
              Color(0xFF0F2027),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Traveler',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Login to continue',
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Email or Mobile (Unified Field)
                    TextField(
                      controller: controller.emailOrPhoneController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputDecoration('Email or Phone', Icons.person),
                    ),
                    const SizedBox(height: 20),

                    // Password
                    TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputDecoration('Enter Password', Icons.lock),
                    ),
                    const SizedBox(height: 10),
                    // Forgot Password
Align(
  alignment: Alignment.centerRight,
  child: TextButton(
    onPressed:(){
      Get.to(() => ForgotPasswordView());

    },
    child: Text(
      'Forgot Password?',
      style: GoogleFonts.poppins(
        color: Colors.tealAccent,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
),
const SizedBox(height: 10),


                    // Login Button
       CustomButton(
  isLoading: controller.isLoading,
  onPressed: controller.login,
  text: 'Login',
  backgroundColor: Colors.tealAccent[700]!,
  textColor: Colors.white,
),

                    const SizedBox(height: 20),

                    // OR Divider
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("OR", style: GoogleFonts.poppins(color: Colors.white54)),
                        ),
                        const Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Google
                    OutlinedButton.icon(
                      icon: Image.asset('assets/icons/google.png', height: 24),
                      onPressed: controller.loginWithGoogle,
                      style: outlinedButtonStyle(),
                      label: Text('Login with Google', style: GoogleFonts.poppins(fontSize: 15)),
                    ),
                    const SizedBox(height: 12),

                    // Apple
                    OutlinedButton.icon(
                      icon: Image.asset('assets/icons/apple.png', height: 24),
                      onPressed: controller.loginWithApple,
                      style: outlinedButtonStyle(),
                      label: Text('Login with Apple', style: GoogleFonts.poppins(fontSize: 15)),
                    ),
                    const SizedBox(height: 40),

                    // Register Link
                    GestureDetector(
                      onTap: controller.goToRegister,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          style: GoogleFonts.poppins(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: ' Sign Up',
                              style: GoogleFonts.poppins(
                                color: Colors.tealAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      prefixIcon: Icon(icon, color: Colors.white54),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
    );
  }

  ButtonStyle outlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.white24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(50),
    );
  }
}
