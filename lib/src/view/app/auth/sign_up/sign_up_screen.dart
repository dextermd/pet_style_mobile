import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_style_mobile/blocs/sign_up/sign_up_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/strings.dart';
import 'package:pet_style_mobile/src/view/widget/app_bar_auth.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';
import 'package:pet_style_mobile/src/view/widget/reusable_text.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignUp = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  String? _errorMsg;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool signUpRequired = false;

  IconData iconPassword = CupertinoIcons.eye_fill;
  IconData iconConfirmPassword = CupertinoIcons.eye_fill;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          setState(() {
            return;
          });
        }
      },
      child: Scaffold(
        appBar: const AppBarAuth(title: 'Sign Up'),
        body: GestureDetector(
          onTap: () {
            _nameFocusNode.unfocus();
            _emailFocusNode.unfocus();
            _passwordFocusNode.unfocus();
            _confirmPasswordFocusNode.unfocus();
            
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  const Center(
                    child: ReusableText(
                        text: 'Enter your details below & free sign up'),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    padding: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: Form(
                      key: _formSignUp,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ReusableText(text: 'Name'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              hintText: 'Enter your name',
                              obscureText: false,
                              keyboardType: TextInputType.name,
                              prefixIcon:
                                  const Icon(CupertinoIcons.person_fill),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this field';
                                } else if (val.length > 30) {
                                  return 'Name to long';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const ReusableText(text: 'Email'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              hintText: 'Enter your email adress',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(CupertinoIcons.mail_solid),
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
                          SizedBox(height: 10.h),
                          const ReusableText(text: 'Password'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              hintText: 'Password',
                              obscureText: obscurePassword,
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(CupertinoIcons.lock_fill),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this firld';
                                } else if (!passwordRexExp.hasMatch(val)) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
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
                          SizedBox(height: 10.h),
                          const ReusableText(text: 'Confirm Password'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _confirmPasswordController,
                              focusNode: _confirmPasswordFocusNode,
                              hintText: 'Confirm Password',
                              obscureText: obscureConfirmPassword,
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(CupertinoIcons.lock_fill),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please fill in this firld';
                                } else if (!passwordRexExp.hasMatch(val)) {
                                  return 'Please enter a valid password';
                                } else if (val != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureConfirmPassword =
                                        !obscureConfirmPassword;
                                    if (obscureConfirmPassword) {
                                      iconConfirmPassword =
                                          CupertinoIcons.eye_fill;
                                    } else {
                                      iconConfirmPassword =
                                          CupertinoIcons.eye_slash_fill;
                                    }
                                  });
                                },
                                icon: Icon(iconConfirmPassword),
                              ),
                            ),
                          ),
                          SizedBox(height: 50.h),
                          !signUpRequired
                              ? MyButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  text: 'Sign Up',
                                  onPressed: () async {
                                    // if (_formSignUp.currentState!.validate()) {
                                    //   //MyUser myUser = MyUser.empty;
                                    //   //myUser = myUser.copyWith(
                                    //     email: _emailController.text,
                                    //     name: _nameController.text,
                                    //   );
                                    //   setState(() {
                                    //     context.read<SignUpBloc>().add(
                                    //         SignUpRequired(myUser,
                                    //             _passwordController.text));
                                    //   });
                                    // }
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryElement,
                                  ),
                                ),
                          //const Center(child: CircularProgressIndicator()),
                          SizedBox(height: 20.h),
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
    );
  }
}