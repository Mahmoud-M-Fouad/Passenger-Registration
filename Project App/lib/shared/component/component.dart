

import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:saud_app/shared/component/show_dialog.dart';

import '../cubit/cubit_app.dart';
import 'theme.dart';

DateTime selectedDate = DateTime.now();
var cubit ;

Future DatePicker(BuildContext ctx , TextEditingController t)
{
  return showDatePicker(
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2050),
    context: ctx,
  );
}

cancelButtonMethod(BuildContext context)
{
  Navigator.pop(context);
}

updateButtonMethod(BuildContext context , var secondRoute)
{
  navigatorTo(context , secondRoute);
}

navigatorTo(BuildContext context ,  var secondRoute )
{
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => secondRoute),
  );
}

buildTextFieldToAdd({
  required TextEditingController controller,
  required String text,
  required String validate,
  required TextInputType type,
  required IconData icon,
})
{
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    height: 90,
    child: TextFormField(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      controller: controller,
      onChanged: (val) {},
      onFieldSubmitted: (val) {},
      validator: (value) =>value!.isEmpty ? validate:null,
      keyboardType: type,
      decoration:  InputDecoration(
        hintText: text,
        label:Text(text , style: subHeadingStyleUseTextField,textAlign: TextAlign.right,),
        border:const OutlineInputBorder(),
        suffixIcon:Icon(icon),
        prefixIcon: IconButton(onPressed: (){controller.text ="";},icon: const Icon(Icons.clear)),

      ),
    ),
  );
}

buildTextFieldToSearch({
  required TextEditingController controller,
  required String text,
  required String validate,
  required TextInputType type,
  required IconData icon,
  required String onChange,
  required Function onChangeFun,
})
{
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    height: 90,
    child: TextFormField(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      controller: controller,
      onChanged: (val) {
        onChange = val;
        onChangeFun();
      },
      onFieldSubmitted: (val) {},
      validator: (value) =>value!.isEmpty ? validate:null,
      keyboardType: type,
      decoration:  InputDecoration(
        hintText: text,
        label:Text(text , style: subHeadingStyleUseTextField,textAlign: TextAlign.right,),
        border:const OutlineInputBorder(),
        suffixIcon:Icon(icon),
        prefixIcon: IconButton(onPressed: (){controller.text ="";},icon: const Icon(Icons.clear)),

      ),
    ),
  );
}

buildTextFieldToAddNotes({
  required TextEditingController controller,
  required String text,
  required TextInputType type,
  required IconData icon,
})
{
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    height: 90,
    child: TextFormField(
      textDirection: TextDirection.rtl,

      textAlign: TextAlign.right,
      controller: controller,
      onChanged: (val) {},
      onFieldSubmitted: (val) {},
      keyboardType: type,
      decoration:  InputDecoration(
        hintText: text,
        label:Text(text , style: subHeadingStyleUseTextField,textAlign: TextAlign.right,),
        border:const OutlineInputBorder(),
        suffixIcon:Icon(icon),
        prefixIcon: IconButton(onPressed: (){controller.text ="";},icon: const Icon(Icons.clear)),

      ),
    ),
  );
}

buildMaterialButton({
  required Color color,
  required String text,
  required var function,
})
{
  return MaterialButton(
    color: color,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
    onPressed: function,
    child:Text(text ,style: headingStyle ),
  );
}




buildImage({
  required double radius ,
  required String imagePath ,
  required double h ,
  required double w
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      radius: radius,
      child: Image.asset(imagePath,height: h,width: w,),
    ),
  );
}

buildImageToUpdate({
  required double radius ,
  required String imagePath ,
  required double h ,
  required   w
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      backgroundImage: MemoryImage(base64Decode(imagePath)),
      radius: radius,
    ),
  );
}

buildImageProfile({
  required double radius ,
  required String imagePath ,
} )
{
  return Padding(
    padding: const EdgeInsets.all(10),
    child: CircleAvatar(
      backgroundImage: AssetImage(imagePath),
      radius: radius,
    ),
  );
}

buildCopy({
  required String textCopy ,required BuildContext context
})
{
  FlutterClipboard.copy(textCopy).then(( value ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('تم النسخ' , style: TextStyle(color: Colors.green,fontSize: 18),textAlign: TextAlign.right,),
      ),
    );
});
}

buildPast({
  required String textCopy ,required String pasteValue
})
{
  FlutterClipboard.paste().then((value) {
    textCopy = value;
    pasteValue = value;
  });

}