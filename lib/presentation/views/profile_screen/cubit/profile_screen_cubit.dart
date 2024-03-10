import 'dart:io';

import 'package:flash_chat/core/api/firebase_client.dart';
import 'package:flash_chat/presentation/views/profile_screen/cubit/profile_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserCubit extends Cubit<UpdateUserState>{
  UpdateUserCubit() : super(Initial());

  Future<void> addUserInfo(String name, String about, File? image) async {   
       
      if(name.isNotEmpty || about.isNotEmpty){
        emit(Loading());
        await Future.delayed(const Duration(seconds: 1),() async {  
        try{
          API.selfInfo = API.selfInfo.copyWith(name: name, about: about);         
          API.addSelfInfo(); 
          if(image != null){
            await updateImage(image);
          }                 
          emit(Success());
        } catch (e){
          emit(Failure("An error occured. Please try again."));
        }     
         });
        
      }
    
}

Future<void> logOut() async {
  emit(LogOutLoading());
  await Future.delayed(Duration(seconds: 3),(){
   API.logOut().whenComplete(() => emit(LogOutSuccess()));
    
  });
}

Future<void> updateImage(File? image) async {
    if (image != null) {      
      await API.updateProfilePicture(image);      
    }
  }

    
}