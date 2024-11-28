import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/strings.dart';
import 'package:pet_style_mobile/src/view/app/menu/app_bar_back.dart';
import 'package:pet_style_mobile/src/view/widget/my_button.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';
import 'package:pet_style_mobile/src/view/widget/reusable_text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formEditProfile = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
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
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBack(
        onPressed: () {
          context.pop();
        },
        title: 'Редактировать профиль',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) {
            if (current is UserUpdated || current is UpdateUserDataError) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoaded) {
              _nameController.text = state.user.name ?? '';
              _emailController.text = state.user.email ?? '';
              _phoneNumberController.text = state.user.phone ?? '';

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Form(
                          key: _formEditProfile,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ReusableText(text: 'Name'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: MyTextField(
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  contentPadding: 12,
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
                              SizedBox(height: 10),
                              const ReusableText(text: 'Email'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: MyTextField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  contentPadding: 12,
                                  hintText: 'Enter your email adress',
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon:
                                      const Icon(CupertinoIcons.mail_solid),
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
                              SizedBox(height: 10),
                              const ReusableText(text: 'Phone Number'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: MyTextField(
                                  controller: _phoneNumberController,
                                  focusNode: _phoneNumberFocusNode,
                                  contentPadding: 12,
                                  hintText: 'Enter your phone number',
                                  obscureText: false,
                                  keyboardType: TextInputType.phone,
                                  prefixIcon:
                                      const Icon(CupertinoIcons.phone_fill),
                                  errorMsg: _errorMsg,
                                  validator: (val) {
                                    // if (val!.isEmpty) {
                                    //   return 'Please fill in this firld';
                                    // }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              if (state.user.provider == 'email')
                                const ReusableText(text: 'New Password'),
                              if (state.user.provider == 'email')
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: MyTextField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    contentPadding: 12,
                                    hintText: 'New Password',
                                    obscureText: obscurePassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon:
                                        const Icon(CupertinoIcons.lock_fill),
                                    errorMsg: _errorMsg,
                                    validator: (val) {
                                      if (!passwordRexExp.hasMatch(val!) &&
                                          val.isNotEmpty) {
                                        return 'Please enter a valid password';
                                      }
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                          if (obscurePassword) {
                                            iconPassword =
                                                CupertinoIcons.eye_fill;
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
                              if (state.user.provider == 'email')
                                SizedBox(height: 10),
                              if (state.user.provider == 'email')
                                const ReusableText(
                                    text: 'Confirm New Password'),
                              if (state.user.provider == 'email')
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: MyTextField(
                                    controller: _confirmPasswordController,
                                    focusNode: _confirmPasswordFocusNode,
                                    contentPadding: 12,
                                    hintText: 'Confirm New Password',
                                    obscureText: obscureConfirmPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIcon:
                                        const Icon(CupertinoIcons.lock_fill),
                                    errorMsg: _errorMsg,
                                    validator: (val) {
                                      if (!passwordRexExp.hasMatch(val!) &&
                                          val.isNotEmpty) {
                                        return 'Please enter a valid password';
                                      } else if (val !=
                                          _passwordController.text) {
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
                              SizedBox(height: 50),
                              !signUpRequired
                                  ? MyButton(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      text: 'Сохранить',
                                      onPressed: () async {
                                        if (_formEditProfile.currentState!
                                            .validate()) {
                                          final updateUser =
                                              state.user.copyWith(
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            phone: _phoneNumberController.text,
                                          );
                                          context.read<UserBloc>().add(
                                                UpdateUserDataEvent(
                                                    user: updateUser,
                                                    newPassword:
                                                        _passwordController
                                                            .text),
                                              );
                                        }
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryElement,
                                      ),
                                    ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
