

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPicker extends StatefulWidget {
  const MyPicker({Key? key}) : super(key: key);

  @override
  _MyPickrState createState() => _MyPickrState();
}

class _MyPickrState extends State<MyPicker> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: imageFile == null
            ? Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                    height: 150,
                    width: 200,
                    child: Image.network(
                        'https://www.lifewire.com/thmb/P856-0hi4lmA2xinYWyaEpRIckw=/1920x1326/filters:no_u'
                            'pscale():max_bytes(150000):strip_icc()/cloud-upload-a30f385a928e44e199a62210d578375a.jpg')),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () {
                          imageFromGallery();
                        },
                        child: Text("GALLERY"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () {
                          imageFromCamera();
                        },
                        child: Text("CAMERA"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
            : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Uploaded Image",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
        ));
  }

  imageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  imageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}


// base64.text =
//                             ImageUtils.fileToBase64(File(pickedFile.path));