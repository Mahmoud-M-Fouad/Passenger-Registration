import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../layout/home_layout.dart';
import '../model/model.dart';
import '../shared/component/component.dart';
import '../shared/component/db.dart';
import 'package:intl/intl.dart';

import '../shared/component/theme.dart';
import '../shared/shared_preferences/shared_preferences.dart';
class UpdatePerson extends StatefulWidget {
  const UpdatePerson( {Key? key, }) : super(key: key);

  @override
  State<UpdatePerson> createState() => _UpdatePersonState();
}

class _UpdatePersonState extends State<UpdatePerson> {
  @override
  Widget build(BuildContext context) {
    String formattedDate="";
    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController jobController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController moneyController = TextEditingController();
    TextEditingController notesController = TextEditingController();


    var formKey = GlobalKey <FormState>();
//--------------------------------------------
    void validateUpdate(int id) async {
      final FormState? form = formKey.currentState;

      if (form!.validate()) {
          var math = Passenger(
              id: id,
              money: moneyController.text,
              country: countryController.text,
              job: jobController.text,
              age: ageController.text,
              address: addressController.text,
              name: nameController.text,
              phone: phoneController.text,
              notes: notesController.text,
              date: formattedDate,
              picture: image64!,
          );
          await updatePassenger(math , context);
        print(id);
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }
//----------------------------------------------
    void validateshow(int id) async {
      var list = await passengerId(id);
      print(list);
       nameController.text = list[0].name;
       phoneController.text =  list[0].phone;
       addressController.text =  list[0].address;
       ageController.text =  list[0].age;
       jobController.text =  list[0].job;
       countryController.text =  list[0].country;
       moneyController.text =  list[0].money;
       notesController.text =  list[0].notes;
      formattedDate = list[0].date;
      image64 = list[0].picture;
    }
    //-----------------------------------------

    return Scaffold(
      appBar: AppBar(
        title:Text("تعديل بيانات المسافر",style: headingStyle,),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                list = await allPassenger();
                var id = SharedClass.getInt(key: 'ID');
                print(await id);
                validateshow(id);
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
          child:Form(
            key: formKey,
            child:  Column(
              children: [
                buildTextFieldToAdd(
                  controller: nameController,
                  text:"أسم المسافر",
                  validate:'أدخل إسم المسافر',
                  type: TextInputType.name,
                  icon: Icons.person,
                ),
                buildTextFieldToAdd(
                  controller: phoneController,
                  text:"رقم الهاتف",
                  validate:'أدخل رقم الهاتف',
                  type: TextInputType.phone,
                  icon: Icons.phone,
                ),
                buildTextFieldToAdd(
                  controller: addressController,
                  text:"عنوان المسافر",
                  validate:'أدخل عنوان المسافر',
                  type: TextInputType.streetAddress,
                  icon: Icons.location_city_outlined,
                ),
                buildTextFieldToAdd(
                  controller: ageController,
                  text:"عمر المسافر",
                  validate:'أدخل عمر المسافر',
                  type: TextInputType.number,
                  icon: Icons.numbers_outlined,
                ),
                buildTextFieldToAdd(
                  controller: jobController,
                  text:"مؤهل المسافر",
                  validate:'ادخل مؤهل المسافر',
                  type: TextInputType.text,
                  icon: Icons.work_history_outlined,
                ),
                buildTextFieldToAdd(
                  controller: countryController,
                  text:"البلد المسافر لها",
                  validate:'أدخل البلد المسافر لها',
                  type: TextInputType.text,
                  icon: Icons.airplanemode_active_outlined,
                ),
                buildTextFieldToAdd(
                  controller: moneyController,
                  text:"الفلوس",
                  validate:'أدخل الفلوس ',
                  type: TextInputType.number,
                  icon: Icons.monetization_on_rounded,
                ),

                buildTextFieldToAddNotes(
                  controller: notesController,
                  text:"الملاحظات",
                  type: TextInputType.text,
                  icon: Icons.note_alt,
                ),
/*
                buildImageToUpdate(
                  radius: 150,
                  w: 100,
                  h: 100,
                  imagePath: image64!,
                ),
*/
                buildMaterialButton(
                  color: Colors.deepPurpleAccent,
                  text: "تعديل بيانات المسافر",
                  function: ()
                  {
                    var id = SharedClass.getInt(key: 'ID');
                    validateUpdate(id);
                  },
                )

              ],
            ),
          )
      ),
    );
  }

  File? imageFile ;
  Uint8List? byte;
  String? image64;
  List<String> images = [];

  imageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  imageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      byte = File(imageFile!.path).readAsBytesSync();
      image64 = base64Encode(byte!);
      //  images.add(image64!);

    }
  }
}
