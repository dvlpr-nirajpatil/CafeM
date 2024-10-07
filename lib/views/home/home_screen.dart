import 'dart:io';

import 'package:cafem/controllers/food_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  openAddFoodForm(context) {
    TextEditingController titleField = TextEditingController();
    TextEditingController descField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    FoodController().clearImages();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text("Upload Food Images"),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                FoodController().pickImage();
              },
              child: Consumer<FoodController>(
                builder: (context, controller, _) {
                  return controller.images.isEmpty
                      ? DottedBorder(
                          dashPattern: [15, 5],
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),
                          child: ClipRect(
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_rounded,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Upload Food Image")
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          clipBehavior: Clip.antiAlias,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: double.infinity,
                          child: PageView(
                            children: List.generate(
                              controller.images.length,
                              (index) => Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.file(
                                      File(controller.images[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: IconButton.filled(
                                      color: Colors.red,
                                      onPressed: () {
                                        controller.removeImage(index);
                                      },
                                      icon: Icon(Icons.close),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Food Title"),
            TextField(
              controller: titleField,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Food Description"),
            TextField(
              controller: descField,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Food Price"),
            TextField(
              controller: priceField,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child:
                  Consumer<FoodController>(builder: (context, controller, _) {
                return FilledButton(
                  onPressed: () {
                    controller.addFood(
                        title: titleField.text,
                        desc: descField.text,
                        price: priceField.text);
                  },
                  child: controller.isLoading
                      ? CircularProgressIndicator.adaptive()
                      : Text("Add Product"),
                );
              }),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom * 1.2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          openAddFoodForm(context);
        },
      ),
      appBar: AppBar(
        title: Text("Food Menu"),
      ),
    );
  }
}
