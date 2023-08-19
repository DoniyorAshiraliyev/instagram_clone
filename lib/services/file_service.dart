import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth_service.dart';

class FileService {
  static final _storage = FirebaseStorage.instance.ref();
  static const folder_user = "user_images";
  static const folder_post = "post_images";

  static Future<String> uploadUserImage(File image) async {
    String uid = AuthService.currentUserId();
    String imgName = uid;
    var firebaseStorageRef = _storage.child(folder_user).child(imgName);
    var uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final String downloadUrl = await firebaseStorageRef.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  static Future<String> uploadPostImage(File image) async {
    String uid = AuthService.currentUserId();
    String imgName = "${uid}_${DateTime.now()}";
    var firebaseStorageRef = _storage.child(folder_post).child(imgName);
    var uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    final String downloadUrl = await firebaseStorageRef.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}