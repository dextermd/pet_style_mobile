import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/sign_up/sign_up_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/strings.dart';
import 'package:pet_style_mobile/src/utils/app_utils.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/router/app_routes.dart';
import 'package:pet_style_mobile/src/view/widget/my_elevation_button.dart';
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
            signUpRequired = false;
            context.goNamed(AppRoutes.splash);
          });

          AppUtils.showToastSuccess(
              context, '', 'Вы успешно зарегистрировались');
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          setState(() {
            signUpRequired = false;
          });
          AppUtils.showToastError(context, '', state.message);
        }
      },
      child: Scaffold(
        appBar: AppBarBack(
          title: 'Регистрация',
          backgroundColor: AppColors.primaryTransparent,
          onPressed: () {
            context.pop();
          },
        ),
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
                    child: ReusableText(text: 'Введите данные для регистрации'),
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
                          const ReusableText(text: 'Имя'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              hintText: 'Введите ваше имя',
                              obscureText: false,
                              keyboardType: TextInputType.name,
                              prefixIcon:
                                  const Icon(CupertinoIcons.person_fill),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Пожалуйста, заполните это поле';
                                } else if (val.length > 30) {
                                  return 'Имя не должно превышать 30 символов';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const ReusableText(text: 'Емаил'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              hintText: 'Введите ваш email',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(CupertinoIcons.mail_solid),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Пожалуйста, заполните это поле';
                                } else if (!emailRexExp.hasMatch(val)) {
                                  return 'Пожалуйста, введите действительный email';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const ReusableText(text: 'Пароль'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              hintText: 'Введите пароль',
                              obscureText: obscurePassword,
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(CupertinoIcons.lock_fill),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Пожалуйста, заполните это поле';
                                } else if (!passwordRexExp.hasMatch(val)) {
                                  return 'Пожалуйста, введите действительный пароль\nПароль должен содержать не менее 8 символов, включая цифры, заглавные и строчные буквы';
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
                          const ReusableText(text: 'Подтвердите пароль'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MyTextField(
                              controller: _confirmPasswordController,
                              focusNode: _confirmPasswordFocusNode,
                              hintText: 'Подтвердите пароль',
                              obscureText: obscureConfirmPassword,
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(CupertinoIcons.lock_fill),
                              errorMsg: _errorMsg,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Пожалуйста, заполните это поле';
                                } else if (!passwordRexExp.hasMatch(val)) {
                                  return 'Пожалуйста, введите действительный пароль\nПароль должен содержать не менее 8 символов, включая цифры, заглавные и строчные буквы';
                                } else if (val != _passwordController.text) {
                                  return 'Пароли не совпадают';
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
                              ? MyElevatedButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  text: 'Зарегистрироваться',
                                  onPressed: () async {
                                    if (_formSignUp.currentState!.validate()) {
                                      context
                                          .read<SignUpBloc>()
                                          .add(SignUpRequired(
                                            _nameController.text,
                                            _emailController.text,
                                            _passwordController.text,
                                          ));
                                    }
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryElement,
                                  ),
                                ),
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
