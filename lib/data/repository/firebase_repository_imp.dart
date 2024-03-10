import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/core/errors.dart';
import 'package:flash_chat/domain/repository/firebase_repository.dart';
import 'package:flash_chat/domain/usecase/firebase_usecases/authentication/auth_sign_in_usecase.dart';

import '../../core/api/firebase_client.dart';
import '../model/user_detail/user_detail.dart';

class FirebaseRepositoryImpl implements FirebaseRepository{

  @override
  Future<Either<Failure, bool>> authSignIn(AuthParams params) async{
    try{
      UserCredential userCredential = await API.auth.
      signInWithEmailAndPassword(email: params.email, password: params.password);
      return Right(userCredential.user != null);
      
    }on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? "An error occurred";
      return Left(FirebaseAuthExceptionFailure(errorMessage));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> authSignUp(AuthParams params) async{
    try{
      UserCredential userCredential = await API.auth.
      createUserWithEmailAndPassword(email: params.email, password: params.password);
      
      return Right(userCredential.user != null);
      
    }on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? "An error occurred";
      return Left(FirebaseAuthExceptionFailure(errorMessage));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<UserDetail>>>> userInfo() async{
    try{
      CollectionReference userCollections = API.fireStore.collection('users');
    QuerySnapshot snapshot = await userCollections.get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    final users = userCollections.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map<UserDetail>((e) => UserDetail.fromJson(e.data() as Map<String, dynamic>))
            .toList());
    return Right(users);
    }on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  }
