import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/firebase_client.dart';

class ImageCubit extends Cubit<String?> {
  ImageCubit() : super("");

  Future<void> setImageUrl() async{
    final imageFile = await API.getSelfInfo().then((value) => API.selfInfo.image);    
    emit(imageFile);
  }
}


