import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slogan/components/constants/constants.dart';
import 'package:slogan/components/reusable_components/reusable_components.dart';
import 'package:slogan/moduels/slogan/home_activity/home_activity.dart';
import 'package:slogan/moduels/slogan/signin_activity/signin_statemangment/signin_cubit.dart';
import 'package:slogan/moduels/slogan/signin_activity/signin_statemangment/signin_states.dart';
import 'package:slogan/moduels/slogan/signup_activity/signup_activity.dart';
import 'package:slogan/shared_helper/sharedpreferences_helper/sharedpreferences.dart';
import 'package:slogan/styles/colors.dart';

class SignInActivity extends StatelessWidget {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SignInActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            if (state.signInModel!.status == true) {
              SharedPreferenceHelper.saveData(
                      key: "token", value: state.signInModel!.data!.token)
                  .then((value) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SloganHomeActivity()));
              });
              showToast(
                  message: state.signInModel!.message,
                  toastStates: ToastStates.SUCCESS);
            }
          } else if (state is SignInErrorState) {
            showToast(
                message: state.signInErrorModel!.message,
                toastStates: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          SignInCubit signInCubit = SignInCubit.get(context);

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
                        Center(
                          child: Image.asset(
                            "assets/images/onboard_0.png",
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome to $mainTitle",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                        ),
                        Text(
                          "Sign In Now To See Our Hot Offers...",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: defaultTextField(
                            textEditingController: emailController,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: defaultTextField(
                            textEditingController: passwordController,
                            labelText: "Password",
                            prefixIcon: Icons.lock_outlined,
                            suffixIcon: signInCubit.passwordIcon,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: signInCubit.isPasswordShown,
                            onPressedIconSuffix: () {
                              signInCubit.changePasswordIconState();
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
                        (state is SignInLoadingState)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : defaultMaterialButton(
                                color: mainColor,
                                splashColor: Colors.black,
                                vertical: 10,
                                horizontal: 40,
                                child: Text(
                                  "Sign In",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          letterSpacing: 0.5),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await signInCubit
                                        .userSignIn(
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .whenComplete(
                                          () {
                                            if(state is SignInSuccessState){
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                  const SloganHomeActivity(),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                  }
                                },
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpActivity()));
                              },
                              child: const Text("Sign Up"),
                            ),
                          ],
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
        },
      ),
    );
  }
}
