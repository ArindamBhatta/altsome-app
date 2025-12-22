import 'package:altsome_app/page/Authentication/sign_in_form.dart';
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import '../../altsome_app.dart';
import '../reusable_widgets/custom_text_form_field.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;
  String? _confirmPassword;

  Future<void> submitForm() async {
    if (_password != _confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return null;
    }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(
        'Form submitted! Email: $_email, Password: $_password confirm: $_confirmPassword',
      );

      // Simulate network
      await Future.delayed(Duration(seconds: 1));

      print('User registered (simulated)!');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AltsomeApp(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        title: Text('Sign Up Form'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.blue[100]!,
              Colors.blue[200]!,
              Colors.blue[300]!,
              Colors.blue[400]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CustomTextFormField(
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value?.trim();
                    },
                  ),
                  SizedBox(height: 16),

                  //* Password
                  CustomTextFormField(
                    labelText: 'Enter Password',
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      } else if (value.contains(' ')) {
                        return 'Password cannot contain spaces';
                      } else if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Password must contain at least one uppercase letter';
                      } else if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Password must contain at least one number';
                      } else if (!value
                          .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Password must contain at least one special character';
                      }
                      _password = value;
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 16),

                  //* Confirm Password
                  CustomTextFormField(
                    labelText: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value != _password) {
                        return 'not match $_password with $value';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _confirmPassword = value;
                    },
                  ),

                  //* Submit Button
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignInForm(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Color.fromARGB(255, 240, 243, 33),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
