import 'dart:io';

import 'package:cafem/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodController extends ChangeNotifier {
  static FoodController instance = FoodController.internal();
  FoodController.internal();
  factory FoodController() => instance;
  bool isLoading = false;
  set loading(value) {
    isLoading = value;
    notifyListeners();
  }

  clearImages() {
    images.clear();
    notifyListeners();
  }

  List<XFile> images = [];

  pickImage() async {
    List<XFile> images = await ImagePicker().pickMultiImage();

    if (images.isNotEmpty) {
      this.images = images;
      notifyListeners();
    }
  }

  removeImage(index) {
    images.removeAt(index);
    notifyListeners();
  }

  uploadFoodImage() async {
    List<String> imageUrl = [];

    images.forEach((image) async {
      String? url = await StorageService().uploadFile(File(image.path));
      if (url != null) {
        imageUrl.add(url);
      }
    });

    return imageUrl;
  }

  addFood({title, desc, price}) async {
    loading = true;

    List<String> imageUrl = await uploadFoodImage();

    await FirebaseFirestore.instance.collection('foodItems').add({
      'title': title,
      'desc': desc,
      'price': price,
      'images': imageUrl,
      'isAvailable': true
    });
    loading = false;
  }
}
