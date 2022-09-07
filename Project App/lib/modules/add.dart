
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saud_app/shared/component/theme.dart';
import '../model/model.dart';
import '../shared/component/component.dart';
import '../shared/component/db.dart';
import 'package:intl/intl.dart';
class AddPerson extends StatefulWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController jobController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController moneyController = TextEditingController();
    TextEditingController notesController = TextEditingController();
    var formKey = GlobalKey <FormState>();
    late int id ;
    void validateAndSave()async {
      final FormState? form = formKey.currentState;
      if(imageFile!=null)
        {
          if (form!.validate())
          {
            id = await maxPassengerID() >=0?await maxPassengerID() : 0;
            print(id);
            DateTime now = DateTime.now();
            setState(() {
              String formattedDate = DateFormat('yyyy-MM-dd').add_jm().format(now);
              var person =  Passenger( id: ++id, name: nameController.text,
                  phone:phoneController.text,address: addressController.text,
                  age: ageController.text,job: jobController.text,
                  country: countryController.text,money: moneyController.text,
                  date: formattedDate, notes : notesController.text, picture: image64!
              );
              insertPassenger(person , context);
            });
            print('Form is valid');
          }
          else {
            print('Form is invalid');
          }
        }
      else{
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          const SnackBar(
            content: Text('من فضلك أختار صورة للمسافر' , style: TextStyle(color: Colors.red,fontSize: 18),textAlign: TextAlign.right,),),
        );
      }
    }
    return Scaffold(

      appBar: AppBar(
        title: const Text("إضافة بيانات مسافر جديد"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Form(
          key: formKey,
          child:  Column(
            children: [
              const Text(" من فضلك أضف الصورة أولاً للمسافر قبل إضافة البيانات"),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.teal.shade400,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(15) //                 <--- border radius here
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IconButton(onPressed: (){
                          imageFromCamera();
                        }, icon: const Icon(Icons.camera_alt)),
                      ),
                      Expanded(
                        child: IconButton(onPressed: (){
                          imageFromGallery();
                        }, icon: const Icon(Icons.image)),
                      ),
                      const Text("صورة للمسافر  " ,style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
              ),
              imageFile == null?Container():
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(
                  imageFile!,
                ),
              ),
              //const SizedBox(height: 50,),
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

              Padding(padding: const EdgeInsets.all(20),
              child: buildMaterialButton(
                color: Colors.deepPurple,
                text: "إضافة المسافر",
                function: validateAndSave,
              ),
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
        .getImage(source: ImageSource.gallery,maxHeight: 350,maxWidth: 350,);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      byte = File(imageFile!.path).readAsBytesSync();
      image64 = base64Encode(byte!);
      //  images.add(image64!);

    }
  }

  imageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera,maxHeight: 350,maxWidth: 350,);
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
