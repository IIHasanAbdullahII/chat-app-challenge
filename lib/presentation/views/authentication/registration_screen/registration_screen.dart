import 'package:flash_chat/core/api/firebase_client.dart';
import 'package:flash_chat/core/helpers.dart';
import 'package:flash_chat/core/navigation/app_routes.dart';
import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_in_usecase.dart';
import 'package:flash_chat/presentation/views/authentication/cubit/login_cubit.dart';
import 'package:flash_chat/presentation/views/authentication/cubit/login_state.dart';
import 'package:flash_chat/presentation/widgets/animated_button_widget.dart';
import 'package:flash_chat/presentation/widgets/base_widget.dart';
import 'package:flash_chat/presentation/widgets/email_text_form_widget.dart';
import 'package:flash_chat/presentation/widgets/password_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/presentation/widgets/animated_text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String passwordValue = "";

  @override
  void dispose() {
    if(mounted){
      _emailController.dispose();
      _confirmPasswordController.dispose();
      _passwordController.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      isDefault: true,
      onClick: () {
        
      },
      isAppBar: true,
      isFullScreen: true,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (_, state) {
          if(state is LoginSuccess){
            API.createUser().then((value) {
              Helpers.showToast(context, "Registration Successful");
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.Add_User_Info_Screen, (route) => false);

            });            
          }
          if(state is LoginFailure){
            Helpers.showToast(context, state.message.toString());
          }
        },
        builder: (context, state) {
          return _buildBody(context, state);
        },
      )
      );
  }

  _buildBody(BuildContext context, AuthState state) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
                child: const Text("Signup with Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25
                ),),
              ),
              const SizedBox(height: 20,),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
                child: const Text("Get chatting with family and friends today by ",
                style: TextStyle(
                  color: Colors.grey
                ),),
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
            offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
                child: const Text("signing up for our chat app",
                style: TextStyle(
                  color: Colors.grey
                ),),
              ),
              const SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: Column(
                children: [              
              EmailTextFormWidget(text: "Email", controller: _emailController, iconData: Icons.email,),
              const SizedBox(height: 20,),
              PasswordTextFormWidget(
                iconData: Icons.lock,
                text: "Password", 
                onChanged: (val){
                  setState(() {
                    passwordValue = val;
                  });                    
                },
                controller: _passwordController),
              const SizedBox(height: 20,),
              PasswordTextFormWidget(
                iconData: Icons.lock,
                text: "Confirm Password", 
                passwordValue: passwordValue,
                fromPasswordField: true,
                onChanged: (val){},
                controller: _confirmPasswordController),
              

                ],
              )),
              const SizedBox(height: 20.0,),
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                    AnimatedButton(text: "Create an account", onClick: (){
                      if(_formKey.currentState!.validate()){
                        context.read<AuthCubit>().signUpUser(
                          AuthParams(
                            email: _emailController.text, 
                            password: _passwordController.text));
                      };
                    }),
                    const SizedBox(height: 20,),
                    Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AnimatedText(
                text: "Already have an account. Log In", 
                onClick: (){
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.Login_Screen, (route) => false);

                },
                color: const Color.fromARGB(255, 37, 151, 136),),
            )
                  ],
                ),
              ))

            ],
          ),
        )
      ]
    );
  }
}