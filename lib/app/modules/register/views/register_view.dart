import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app2/app/routes/app_pages.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController(); // ✅ Added
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),

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
                      'Create your account',
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Full Name
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputDecoration(Icons.person, 'Full Name'),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputDecoration(Icons.phone, 'Mobile Number'),
                    ),
                    const SizedBox(height: 20),
                    // Email
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputDecoration(Icons.email, 'Email Address'),
                    ),
                    const SizedBox(height: 20),

                    // ✅ Mobile Number


                    // Password
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: inputDecoration(Icons.lock, 'Password'),
                    ),
                    const SizedBox(height: 30),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final name = nameController.text.trim();
                          final email = emailController.text.trim();
                          final mobile = mobileController.text.trim();
                          final password = passwordController.text.trim();

                          if (name.isEmpty ||
                              email.isEmpty ||
                              !email.contains('@') ||
                              mobile.length < 8 ||
                              password.length < 6) {
                            Get.snackbar(
                              'Invalid Input',
                              'Please enter valid details in all fields.',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          } else {
                            Get.toNamed(Routes.HOME);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "OR",
                            style: GoogleFonts.poppins(color: Colors.white54),
                          ),
                        ),
                        const Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Google Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: Image.asset('assets/icons/google.png', height: 24),
                        onPressed: () {
                          Get.snackbar('Google Login', 'Coming soon!',
                              backgroundColor: Colors.blueGrey,
                              colorText: Colors.white);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          foregroundColor: Colors.white,
                        ),
                        label: Text(
                          'Login with Google',
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Apple Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: Image.asset('assets/icons/apple.png', height: 24),
                        onPressed: () {
                          Get.snackbar('Apple Login', 'Coming soon!',
                              backgroundColor: Colors.blueGrey,
                              colorText: Colors.white);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          foregroundColor: Colors.white,
                        ),
                        label: Text(
                          'Login with Apple',
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Already have an account?
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account ? ",
                          style: GoogleFonts.poppins(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: ' Login',
                              style: GoogleFonts.poppins(
                                color: Colors.tealAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Terms
                    Text(
                      'By registering, you agree to our Terms & Privacy Policy',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white38,
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

  InputDecoration inputDecoration(IconData icon, String hint) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      prefixIcon: Icon(icon, color: Colors.white54),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
