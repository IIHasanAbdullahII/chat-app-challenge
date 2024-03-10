import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/model/user_detail/user_detail.dart';

class API {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static FirebaseStorage fireStorage = FirebaseStorage.instance;

  static User get user =>  auth.currentUser!;

  static UserDetail selfInfo = UserDetail(
    id: user.uid,
    image: '',
    name: user.displayName.toString(),
    about: "Hey, I'm using Flash Chat",
    email: user.email,
    last_active: '',
    created_at: '',
    isOnline: false,
    push_token: '',
  );

  // Sign in with Google
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<bool> userExist () async{
    return (await fireStore.collection("users").doc(user.uid).get()).exists;
  }

  static Future<void> createUser () async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = UserDetail(
      image: user.photoURL.toString() ?? "",
      name: user.displayName ?? "",
      about: "Hey, I'm using Flash Chat",
      created_at: time,
      id: user.uid,
      isOnline: false,
      last_active: time,
      push_token: '',
      email: user.email,
    );
    return (await fireStore.collection("users").doc(user.uid).set(chatUser.toJson()));
  }

  static Future<void> getSelfInfo () async{
    return await fireStore.collection('users').doc(user.uid)
        .get().then((user) async {
          if(user.exists){
            selfInfo = UserDetail.fromJson(user.data()!);
          } else {
            await createUser().then((value) => getSelfInfo());
          }
        });
  }

  static Future<void> addSelfInfo () async {
    await API.fireStore.collection('users').doc(user.uid).update(
                {
                  'name': selfInfo.name,                  
                  'about': selfInfo.about,

                }
              );
  }

  static Future<void> updateProfilePicture (File file) async{
    final ext = file.path.split('.').last;
    final ref = fireStorage.ref().child("profile_picture/${user.uid}.$ext");
    await ref.putFile(file).whenComplete(() => print("Image Uploaded"));
    final imageUrl = await ref.getDownloadURL();
    final updatedSelfInfo = selfInfo.copyWith(image: imageUrl);
    selfInfo = updatedSelfInfo;
    await API.fireStore.collection('users').doc(user.uid).update(
                {
                  'image': imageUrl,

                }
              );
  
  }

  static Future<void> logOut () async{
    await GoogleSignIn().signOut();

     await auth.signOut();

  }

}
 