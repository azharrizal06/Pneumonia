import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: tinggi,
              width: lebar,
              // color: Colors.amber,
              child: Image.asset(
                "assets/g.png",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                SizedBox(height: 50),
                Text(
                  'Aplikasi pendeteksi penyakit Pneumonia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Image Classification',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Obx(
                      () => controller.image.value != null
                          ? Image.file(
                              controller.image.value!,
                              width: 250,
                            )
                          : SizedBox(
                              width: 300,
                              child:
                                  LottieBuilder.asset("assets/animasi.json")),
                    ),
                  ),
                ),
                Obx(
                  () => controller.output.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              '${controller.output[0]["label"]}'
                                  .replaceFirst(" ", " "),
                              // (${controller.output[0]["confidence"]})
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
                SizedBox(height: 50),
                Obx(
                  () => controller.image.value != null
                      ? ElevatedButton(
                          onPressed: controller.reset,
                          child: Text(
                            'RESET',
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: controller.chooseImage,
                              child: Text(
                                'Pilih dari Galeri',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: controller.cameraRoll,
                              child: Text(
                                'Ambil Foto',
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
