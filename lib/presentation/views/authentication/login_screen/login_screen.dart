import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_in_usecase.dart';
import 'package:flash_chat/presentation/views/authentication/cubit/login_cubit.dart';
import 'package:flash_chat/presentation/views/authentication/cubit/login_state.dart';
import 'package:flash_chat/presentation/widgets/custom_divider_widget.dart';
import 'package:flash_chat/presentation/widgets/email_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_chat/presentation/widgets/animated_button_widget.dart';
import 'package:flash_chat/presentation/widgets/animated_text_widget.dart';
import 'package:flash_chat/presentation/widgets/base_widget.dart';
import 'package:flash_chat/presentation/widgets/password_text_form_widget.dart';
import 'package:flash_chat/core/helpers.dart';
import 'package:flash_chat/core/navigation/app_routes.dart';

import '../../../widgets/custom_row_images_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      isDefault: true,
      onClick: () {},
      isAppBar: true,
      isFullScreen: true,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Helpers.showToast(context, "Login Successful");
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.Dashboard_Screen, (route) => false);
          } else if (state is LoginFailure) {
            Helpers.showToast(context, state.message.toString());
          }
        },
        builder: (context, state) {
          return _signInBodyWidget(context, state);
        },
      ),
    );
  }

  _signInBodyWidget(BuildContext context, AuthState state) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 1.0),
              duration: Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
                child: const Text(
                  "Log in to ChatBox",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 1.0),
              duration: Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
                child: Wrap(
                  children: [
                    Text(
                      "Welcome back! Sign in using your social",
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                    ),
                    Text(
                      "account or email to continue with us",
                      style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomRowImagesWidget(
              firstAssetImage: 'images/facebook.png', 
              secondAssetImage: 'images/google.png', 
              thirdAssetImage: 'images/apple.png',),
              const SizedBox(
                height: 20,
              ),
              const CustomDivider(),
              const SizedBox(
                height: 20.0,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EmailTextFormWidget(
                      controller: _emailController,
                      text: "Email", 
                      iconData: Icons.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PasswordTextFormWidget(
                      iconData: Icons.lock,
                      controller: _passwordController,
                      text: "Password",
                      onChanged: (val) {},
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state is LoginLoading)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Please Wait",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircularProgressIndicator()
                        ],
                      ),
                    if (state is! LoginLoading)
                      AnimatedButton(
                        text: "Log In",
                        onClick: () async {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().signInUser(AuthParams(
                                email: _emailController.text,
                                password: _passwordController.text));
                          }
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: AnimatedText(
                  text: "Don't have an account. Signup",
                  onClick: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.Signup_Screen, (route) => false);
                  },
                  color: const Color.fromARGB(255, 37, 151, 136),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: AnimatedText(
                  text: "Forgot Password?",
                  onClick: () {},
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
