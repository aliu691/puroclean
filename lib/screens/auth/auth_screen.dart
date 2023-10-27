import 'package:flutter/material.dart';
import 'package:puroclean/screens/auth/login_screen.dart';
import 'package:puroclean/screens/auth/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Log Your Activity.',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFFF91919),
                          minimumSize: const Size(150, 56),
                        ),
                        child: Text(
                          'Sign Up',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          RegisterScreen.getRoute(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          minimumSize: const Size(150, 56),
                        ),
                        child: Text(
                          'Sign In',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 20,
                                  ),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          LoginScreen.getRoute(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
