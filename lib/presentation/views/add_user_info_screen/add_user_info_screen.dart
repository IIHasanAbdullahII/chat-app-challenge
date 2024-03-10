import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_info_cubit.dart';
import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_info_state.dart';
import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_profile_image_cubit.dart';
import 'package:flash_chat/presentation/widgets/animated_button_widget.dart';
import 'package:flash_chat/presentation/widgets/base_widget.dart';
import 'package:flash_chat/presentation/widgets/custom_change_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/app_routes.dart';
import '../../widgets/custom_text_form_widget.dart';

class AddUserInfoScreen extends StatefulWidget {
  const AddUserInfoScreen({super.key});

  @override
  State<AddUserInfoScreen> createState() => _AddUserInfoScreenState();
}

class _AddUserInfoScreenState extends State<AddUserInfoScreen> {
  final TextEditingController _userController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<AddUserProfileImageCubit>().resetImage();
    super.initState();
  }

  @override
    void dispose() {
      if (mounted) {
        _userController.dispose();
      }
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {   

    return BaseWidget(
        isDefault: true,
        onClick: () {},
        isAppBar: true,
        isFullScreen: true,
        isBackButton: false,
        isImageRequired: false,
        isTitle: true,
        title: "User Info",
        child: BlocConsumer<AddUserInfoCubit, AddUserInfoState>(
          listener: (context, state) {
            if (state is Success) {              
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.Dashboard_Screen, (route) => false);
            }           
          },          
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ));
  }

  _buildBody(BuildContext context, AddUserInfoState state) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Center(child: CustomChangeImageWidget(imageFile: "", onImageSelected: (image) { 
                context.read<AddUserProfileImageCubit>().setImage(image);
               },)),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: CustomTextFormWidget(
                    isEnabled: true,
                    iconData: Icons.person,
                    text: "Username",
                    controller: _userController),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                          text: "Save",
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AddUserInfoCubit>()
                                  .addUserInfo(
                                    _userController.text,
                                    context.read<AddUserProfileImageCubit>().state.image,
                                    );
                            }
                          }),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
