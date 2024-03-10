import 'dart:io';

import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_profile_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserProfileImageCubit extends Cubit<AddUserProfileImageState> {
  AddUserProfileImageCubit() : super(const AddUserProfileImageState(image: null));
  
  void setImage(File? image) {
    emit(AddUserProfileImageState(image: image));
  }  

  void resetImage(){
    emit(const AddUserProfileImageState(image: null));
  }
}