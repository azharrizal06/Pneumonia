import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<File?> image = Rx<File?>(null);
  RxList output = RxList.empty();

  @override
  void onInit() {
    super.onInit();
    Tflite.loadModel(
      model: 'assets/converted_model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  void classifyImage() async {
    var output = await Tflite.runModelOnImage(
      path: image.value!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    this.output.value = output!;
  }

  void chooseImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    this.image.value = File(image.path);

    classifyImage();
  }

  void cameraRoll() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    this.image.value = File(image.path);

    classifyImage();
  }

  void reset() {
    this.image.value = null;
    this.output.value = [];
  }

  @override
  void onClose() {
    super.onClose();
    Tflite.close();
  }
}
