import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saud_app/modules/search.dart';
import 'package:saud_app/modules/update.dart';
import '../model/model.dart';
import '../shared/component/component.dart';
import '../shared/component/db.dart';
import '../shared/component/show_dialog.dart';
import '../shared/component/theme.dart';
import '../shared/cubit/cubit_app.dart';
import '../shared/shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AllPerson extends StatefulWidget {
  AllPerson({Key? key}) : super(key: key);

  @override
  State<AllPerson> createState() => _AllPersonState();
}

class _AllPersonState extends State<AllPerson> {
  var list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "عرض جميع المسافرين",
          style: headingStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                navigatorTo(context, const SearchScreen());
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () async {
                if (await allPassengerYesOrNo()) {
                  list = await allPassenger();
                  print(await list);
                } else {
                  final scaffold = ScaffoldMessenger.of(context);
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'لا يوجد أي مسافر مسجل',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                }

                setState(() {
                  //--

                  //---
                });
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            list?.isEmpty == null
                ? Container()
                : ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return bulidContainerCourse(index);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: list.length,
// shrinkWrap: true,
                  )
          ],
        ),
      ),
    );
  }

  Widget bulidContainerCourse(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 900,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade600,
                borderRadius: const BorderRadius.all(Radius.circular(
                        15) //                 <--- border radius here
                    ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildNameShow(list: list[index].name, icon: Icons.person),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          imageFromCamera(id: list[index].id, context: context);
                        },
                        onLongPress: () {
                          imageFromGallery(
                              id: list[index].id, context: context);
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 100,
                              backgroundImage: MemoryImage(
                                base64Decode(list[index].picture),
                              ),
                            ),
                            Icon(
                              Icons.add_photo_alternate,
                              color: Colors.yellowAccent.shade700,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          print(list[index].phone);
                          makePhoneCall(phoneNumber: list[index].phone);
                        },
                        onLongPress: () {
                          buildCopy(
                              textCopy: "alsmryemad82@gmail.com",
                              context: context);
                        },
                        child: buildColumnShow(
                            icon: Icons.phone, list: list[index].phone),
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                      buildColumnShow(
                          icon: Icons.location_city, list: list[index].address),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                      buildColumnShow(
                          icon: Icons.numbers_outlined, list: list[index].age),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                      buildColumnShow(
                          icon: Icons.work_history_outlined,
                          list: list[index].job),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                      buildColumnShow(
                          icon: Icons.airplanemode_on_rounded,
                          list: list[index].country),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                      buildColumnShow(
                          icon: Icons.monetization_on_rounded,
                          list: list[index].money),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                      buildColumnShow(
                          icon: Icons.note_alt, list: list[index].notes),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                      buildColumnShow(
                          icon: Icons.date_range, list: list[index].date),
                      const Divider(
                        height: 5,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialogMethod(
                            context: context,
                            cancelButton: () {
                              Navigator.pop(context);
                            },
                            continueButton: () {
                              Navigator.pop(context);
                              deletePassenger(list[index].id, context)
                                  .then((value) async {
                                list = await allPassenger();
                              });
                              setState(() {});
                            },
                            content: const Text(
                              "هل تريد حذف هذا المسافر",
                              textAlign: TextAlign.right,
                            ),
                            title: const Text(
                              "رسالة تنبية",
                              textAlign: TextAlign.right,
                            ),
                            textCancel: 'لا',
                            textContinue: 'نعم',
                          );
                          //
                          print("${list[index].id}");
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red.shade300,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            showDialogMethod(
                              context: context,
                              cancelButton: () {
                                Navigator.pop(context);
                              },
                              continueButton: () {
                                setState(() {
                                  Navigator.pop(context);
                                  SharedClass.setId(
                                      key: 'ID', num: list[index].id);
                                  navigatorTo(context, const UpdatePerson());
                                  print(list[index].id);
                                });
                              },
                              content: const Text(
                                "هل تريد تعديل هذا المسافر",
                                textAlign: TextAlign.right,
                              ),
                              title: const Text(
                                "رسالة تنبية",
                                textAlign: TextAlign.right,
                              ),
                              textCancel: 'لا',
                              textContinue: 'نعم',
                            );
                          },
                          icon: Icon(
                            Icons.update,
                            color: Colors.yellow.shade300,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildColumnShow({required IconData icon, required var list}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: Colors.yellowAccent.shade700,
        ),
        Text(
          "$list",
          style: headingStyle,
          textAlign: TextAlign.right,
          maxLines: 2,
        ),
      ],
    );
  }

  buildNameShow({required IconData icon, required var list}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$list",
          style: headingStyle,
          textAlign: TextAlign.right,
          maxLines: 2,
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(icon, color: Colors.yellowAccent.shade700),
      ],
    );
  }

  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //------
  File? imageFile;

  Uint8List? byte;
  String? image64;
  List<String> images = [];

  imageFromGallery({required int id, required BuildContext context}) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 350,
      maxWidth: 350,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      print("------------------");
      byte = File(imageFile!.path).readAsBytesSync();
      image64 = base64Encode(byte!);
      //  images.add(image64!);
      await updateImage(id: id, photo: image64!, context: context);
    }
  }

  imageFromCamera({required int id, required BuildContext context}) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 350,
      maxWidth: 350,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      byte = File(imageFile!.path).readAsBytesSync();
      image64 = base64Encode(byte!);
      //  images.add(image64!);
      await updateImage(id: id, photo: image64!, context: context);
    }
  }

//----

//----

}
