import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

void uploadFileRemotely(String filePath, String uid) {
  final file = File(filePath);

// Create the file metadata
  final metadata = SettableMetadata(contentType: "image/jpeg");

// Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
  final uploadTask =
      storageRef.child("images/$uid.jpg").putFile(file, metadata);

// Listen for state changes, errors, and completion of the upload.
  uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
    switch (taskSnapshot.state) {
      case TaskState.running:
        // final progress =
        //     100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
        //print("Upload is $progress% complete.");
        break;
      case TaskState.paused:
        //print("Upload is paused.");
        break;
      case TaskState.canceled:
        Get.snackbar('Opps!', 'Image upload was cancled!');
        break;
      case TaskState.error:
        // Handle unsuccessful uploads
        break;
      case TaskState.success:
        Get.snackbar('Awesome!', 'Image uploaded successfully!');
        break;
    }
  });
}
