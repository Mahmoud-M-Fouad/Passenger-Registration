import 'package:flutter/material.dart';
import 'package:saud_app/modules/add.dart';
import 'package:saud_app/modules/update.dart';
import 'package:saud_app/shared/component/component.dart';

import '../modules/all.dart';
import '../modules/profile/profile.dart';
import '../shared/component/db.dart';
import '../shared/component/show_dialog.dart';
import '../shared/component/theme.dart';
import '../shared/cubit/cubit_app.dart';
import '../shared/shared_preferences/shared_preferences.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
var list;
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("الصفحة الرئسية",style: headingStyle,),
        centerTitle: true,
      ),
      body : Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('image/saud.PNG',),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  MaterialButton(
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: (){
                      navigatorTo(context, const AddPerson());
                    },

                    child: const Text("إضافة مسافر جديد" ,style: TextStyle(color: Colors.white), ),
                  ),
                  const SizedBox(height: 20,),
                  MaterialButton(
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: ()async{

                      setState(() {
                        navigatorTo(context, AllPerson());
                        //navigatorTo(context, const AllPerson());

                      });
                    },

                    child: const Text("المسافرين المسجلين من قبل" ,style: TextStyle(color: Colors.white), ),
                  ),
                ],
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  navigatorTo(context, const PeofileScreen());
                }, icon:  Icon(Icons.not_listed_location_rounded,color: Colors.deepPurple.shade200,)),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
