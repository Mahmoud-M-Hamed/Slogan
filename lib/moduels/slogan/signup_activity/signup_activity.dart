import 'package:flutter/material.dart';
import 'package:slogan/components/constants/constants.dart';
import 'package:slogan/components/reusable_components/reusable_components.dart';
import 'package:slogan/moduels/slogan/signin_activity/signin_activity.dart';
import 'package:slogan/shared_helper/dio_helper/dio.dart';
import 'package:slogan/styles/colors.dart';

class SignUpActivity extends StatefulWidget {
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();
  static TextEditingController phoneNumberController = TextEditingController();

  const SignUpActivity({super.key});

  @override
  State<SignUpActivity> createState() => _SignUpActivityState();
}

class _SignUpActivityState extends State<SignUpActivity> {
  final formKey = GlobalKey<FormState>();
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/shopping.png",
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome to $mainTitle",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultTextField(
                      textEditingController: SignUpActivity.userNameController,
                      labelText: "User Name",
                      prefixIcon: Icons.person,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'user name mustn\'t be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: defaultTextField(
                      textEditingController: SignUpActivity.emailController,
                      labelText: "E-Mail",
                      prefixIcon: Icons.email_outlined,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'E-Mail address mustn\'t be empty';
                        } else if (!value.contains("@") ||
                            !value.contains('.')) {
                          return 'E-Mail must have @example.com';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: defaultTextField(
                      textEditingController:
                          SignUpActivity.phoneNumberController,
                      labelText: "Phone Number",
                      prefixIcon: Icons.phone,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone number mustn\'t be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultTextField(
                      textEditingController: SignUpActivity.passwordController,
                      labelText: "Password",
                      prefixIcon: Icons.lock_outlined,
                      suffixIcon: (isShown)
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye,
                      obscureText: isShown,
                      keyboardType: TextInputType.emailAddress,
                      onPressedIconSuffix: () {
                        setState(() {
                          (isShown) ? isShown = false : isShown = true;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password must\'t be empty';
                        } else if (value.length <= 5) {
                          return 'Password too short';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultTextField(
                      textEditingController:
                          SignUpActivity.confirmPasswordController,
                      labelText: "Confirm Password",
                      prefixIcon: Icons.lock_outlined,
                      suffixIcon: (isShown)
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye,
                      obscureText: isShown,
                      keyboardType: TextInputType.emailAddress,
                      onPressedIconSuffix: () {
                        setState(() {
                          (isShown) ? isShown = false : isShown = true;
                        });
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password must\'t be empty';
                        } else if (value.length <= 5) {
                          return 'Password too short';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultMaterialButton(
                    color: mainColor,
                    splashColor: Colors.black,
                    vertical: 10,
                    horizontal: 40,
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white, letterSpacing: 0.5),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        DioHelper.postData(url: 'register', data: {
                          'name': SignUpActivity.userNameController.text,
                          'email': SignUpActivity.emailController.text,
                          'phone': SignUpActivity.phoneNumberController.text,
                          'password': SignUpActivity.passwordController.text
                        }).whenComplete(() => Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => SignInActivity())));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
