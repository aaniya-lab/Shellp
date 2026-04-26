import 'package:flutter/material.dart';
import '../main.dart'; // For HoverScale & DashboardScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // In a real application, you would validate credentials here.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.w900,
          fontSize: 12,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top colorful strip
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: Container(height: 12, color: const Color(0xFFE03A3E))),
                  Expanded(child: Container(height: 12, color: const Color(0xFFFFD200))),
                  Expanded(child: Container(height: 12, color: Colors.black)),
                  Expanded(child: Container(height: 12, color: const Color(0xFFE03A3E))),
                ],
              ),
            ],
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    const Text(
                      'SHELLP',
                      style: TextStyle(
                        color: Color(0xFFE03A3E),
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        letterSpacing: -2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'TERPS FOR TRADE: NO SHELLS ATTACHED',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    // Login Card
                    Container(
                      width: isMobile ? double.infinity : 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 4),
                        boxShadow: const [
                          BoxShadow(color: Color(0xFFFFD200), offset: Offset(10, 10)),
                        ],
                      ),
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN TO THE NEST',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildLabel('USERNAME'),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: TextField(
                              controller: _usernameController,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintText: 'TESTUDO1856',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                            ),
                          ),
                          _buildLabel('PASSWORD'),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintText: '••••••••',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                              onSubmitted: (_) => _login(),
                            ),
                          ),
                          const SizedBox(height: 40),
                          HoverScale(
                            onTap: _login,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(color: Color(0xFFE03A3E), offset: Offset(6, 6)),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ENTER',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
