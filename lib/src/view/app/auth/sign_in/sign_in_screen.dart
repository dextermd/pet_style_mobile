import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_style_mobile/blocs/sign_in/sign_in_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/strings.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';


import 'widgets/square_tile.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignIn = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String? _errorMsg;
  bool obscurePassword = true;
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          setState(() {
            signInRequired = true;
            context.go('/splash');
          });
        } else if (state is SignInProcess) {
          setState(() {
            signInRequired = true;
          });
        } else if (state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = 'Invalid email or password';
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: GestureDetector(
          onTap: () {
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Form(
                        key: _formSignIn,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20.h),
                            Center(
                              child: Lottie.asset('assets/lottie/frt.json',
                                  fit: BoxFit.contain, height: 150.h),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: MyTextField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                hintText: 'Enter your email adress',
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: const Icon(
                                  CupertinoIcons.mail_solid,
                                  color: AppColors.primarySecondIcon,
                                ),
                                errorMsg: _errorMsg,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please fill in this firld';
                                  } else if (!emailRexExp.hasMatch(val)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: MyTextField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                hintText: 'Password',
                                obscureText: obscurePassword,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: const Icon(
                                  CupertinoIcons.lock_fill,
                                  color: AppColors.primarySecondIcon,
                                ),
                                errorMsg: _errorMsg,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please fill in this firld';
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  color: AppColors.primarySecondIcon,
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                      if (obscurePassword) {
                                        iconPassword = CupertinoIcons.eye_fill;
                                      } else {
                                        iconPassword =
                                            CupertinoIcons.eye_slash_fill;
                                      }
                                    });
                                  },
                                  icon: Icon(iconPassword),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              alignment: Alignment.topRight,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 25,
                              child: GestureDetector(
                                onTap: () {},
                                child: const Text("Forgot password?",
                                    style: TextStyle(
                                      color: AppColors.primarySecondText,
                                    )),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            !signInRequired
                                ? MyButton(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    text: 'Log In',
                                    onPressed: () async {
                                      if (_formSignIn.currentState!
                                          .validate()) {
                                        context.read<SignInBloc>().add(
                                              SignInRequired(
                                                  _emailController.text,
                                                  _passwordController.text),
                                            );
                                      } else {}
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                            const SizedBox(height: 30),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.5,
                                      color: AppColors.primaryLine,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Or continue with',
                                      style: TextStyle(
                                          color: AppColors.primarySecondText),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.5,
                                      color: AppColors.primaryLine,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      context
                                          .read<SignInBloc>()
                                          .add(GoogleSignInRequired());
                                    },
                                    child: const SquareTile(
                                        imagePath: 'assets/images/google.png')),
                                const SizedBox(width: 25),
                                const SquareTile(
                                    imagePath: 'assets/images/apple.png')
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Not a member?',
                                  style: TextStyle(
                                      color: AppColors.primarySecondText),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    context.goNamed('sign_up');
                                  },
                                  child: const Text(
                                    'Register now',
                                    style: TextStyle(
                                      color: AppColors.primaryLinkText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
