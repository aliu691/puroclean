// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:puroclean/constants/countries.dart';
import 'package:puroclean/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  static PageRoute<void> getRoute() {
    const settings = RouteSettings(name: '/login');

    return MaterialPageRoute<void>(
      builder: (_) => const LoginScreen(),
      settings: settings,
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Text(
                    'Welcome. What is your phone number?',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntlPhoneField(
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'US',
                          countries: const [canada, us],
                          disableLengthCheck: true,
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        const SizedBox(height: 56),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFFF91919),
                            ),
                            child: Text(
                              'Continue',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(height: 40),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No account yet? ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                RegisterScreen.getRoute(),
                              ),
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.purple,
                                    ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
