import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UploadPictureProvider extends ChangeNotifier {
  List<String> imageUrls = [];
  bool isLoading = false;
  bool isUploading = false;

  List<String> get getImageUrls {
    return imageUrls;
  }

  bool get getIsLoading {
    return isLoading;
  }

  bool get getIsUploading {
    return isUploading;
  }

  //! read images
  Future<void> fetchImages() async {
    isLoading = true;
    notifyListeners();

    // Mock images
    await Future.delayed(Duration(seconds: 1));
    imageUrls = [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ];

    isLoading = false;
    notifyListeners();
  }

  //! upload images
  Future<void> uploadImages() async {
    isUploading = true;
    notifyListeners();
    //* ImagePicker is used to pick an image from device gallery
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      try {
        print("Uploading file from: ${file.path}");
        // Simulate upload
        await Future.delayed(Duration(seconds: 1));

        // Mock new image URL (just use locals or random placeholder)
        String downloadUrl = 'https://via.placeholder.com/150?text=New+Image';
        //* update the image url list and UI
        imageUrls.add(downloadUrl);
        isUploading = false;
        notifyListeners();
      } catch (error) {
        print("Error uploading image: $error");
      } finally {
        isUploading = false;
        notifyListeners();
      }
    }
  }
}
