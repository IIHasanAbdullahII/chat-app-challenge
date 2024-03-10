import 'dart:io';

import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit() : super(const ProfileImageState(image: null));
  
  void setImage(File? image) {
    emit(ProfileImageState(image: image));
  }

  void resetImage(){
    emit(const ProfileImageState(image: null));
  }  
}