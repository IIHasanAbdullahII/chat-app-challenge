import 'dart:io';

import 'package:flash_chat/core/api/firebase_client.dart';
import 'package:flash_chat/presentation/views/add_user_info_screen/cubit/add_user_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserInfoCubit extends Cubit<AddUserInfoState>{
  AddUserInfoCubit() : super(Initial());

  Future<void> addUserInfo(String name, File? image) async {
       
      if(name.isNotEmpty){
        emit(Loading());
        await Future.delayed(const Duration(seconds: 1),() async {  
        try{
          API.selfInfo = API.selfInfo.copyWith(name: name);         
          API.addSelfInfo(); 
          if(image!= null){
            await API.updateProfilePicture(image);
          }      
          emit(Success());
        }catch (e) {
          emit(Failure("An error occured. Please try again later"));
        }         
        });
        
      }
    
}
    
}