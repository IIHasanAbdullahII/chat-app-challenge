import 'package:flash_chat/core/api/firebase_client.dart';
import 'package:flash_chat/presentation/views/authentication/login_screen/login_screen.dart';
import 'package:flash_chat/presentation/views/dashboard_screen/cubit/update_image_cubit.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_image_cubit.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_screen_cubit.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_screen_state.dart';
import 'package:flash_chat/presentation/widgets/animated_button_widget.dart';
import 'package:flash_chat/presentation/widgets/base_widget.dart';
import 'package:flash_chat/presentation/widgets/custom_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers.dart';
import '../../widgets/custom_change_image_widget.dart';

class ProfileScreen extends StatefulWidget {
  final String imageFile;
  const ProfileScreen({super.key, required this.imageFile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String userEmail = '';

  @override
  void initState() {
    _userNameController.text = API.selfInfo.name!;
    _aboutController.text = API.selfInfo.about!;
    userEmail = API.selfInfo.email!;
    context.read<ProfileImageCubit>().resetImage();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _userNameController.dispose();
      _aboutController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        onClick: () {},
        isDefault: true,
        isTitle: true,
        isImageRequired: false,
        isBackButton: false,
        title: 'Profile',
        isAppBar: true,
        isFullScreen: true,
        child: BlocConsumer<UpdateUserCubit, UpdateUserState>(
          listener: (_, state) {
            if (state is Success) {
              Helpers.showToast(context, "User information is updated");
            }
            if (state is Failure) {
              Helpers.showToast(context, state.message);
            }
            if (state is LogOutSuccess) {
              Helpers.hideProgressBar(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            }
            if (state is LogOutLoading) {
              return Helpers.showProgressBar(context);
            }
          },
          builder: (_, state) {
            return _buildBody(context, state);
          },
        ));
  }

  _buildBody(BuildContext context, UpdateUserState state) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: CustomChangeImageWidget(
                imageFile: widget.imageFile,
                onImageSelected: (image) {
                  context.read<ProfileImageCubit>().setImage(image);
                },
              )),
              const SizedBox(
                height: 20,
              ),
              TweenAnimationBuilder(
                tween: Tween(begin: 50.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (BuildContext context, Object? value, Widget? child) { 
                return Transform.translate(
              offset: Offset(double.parse(value.toString()), 0.0), child: child);
               },
                child: Center(
                    child: Text(
                  userEmail,
                  style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormWidget(
                          text: "Name",
                          controller: _userNameController,
                          isEnabled: true,
                          isTitleLabel: false),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormWidget(
                          text: "About", controller: _aboutController),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              if (state is Loading)
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
              if (state is! Loading)
                AnimatedButton(
                    text: "Update",
                    onClick: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<UpdateUserCubit>().addUserInfo(
                            _userNameController.text,
                            _aboutController.text,
                            context.read<ProfileImageCubit>().state.image);
                        // ignore: use_build_context_synchronously
                        await context.read<ImageCubit>().setImageUrl();
                      }
                    }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TweenAnimationBuilder(
                        tween:
                            Tween(begin: const Offset(0.0, 1.0), end: const Offset(0, 0)),
                        duration: const Duration(milliseconds: 1500),
                        builder: (BuildContext context, Offset offset,
                            Widget? child) {
                          return Transform.translate(
                            offset: offset * 50,
                            child: child,
                          );
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: const Text("Logout"),
                                    content:
                                        const Text("Do you want to logout"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            context
                                                .read<UpdateUserCubit>()
                                                .logOut();
                                          },
                                          child: const Text("Yes"))
                                    ],
                                  );
                                });
                          },
                          // ignore: sort_child_properties_last
                          child: const Text("Logout",
                              style: TextStyle(fontSize: 16)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
