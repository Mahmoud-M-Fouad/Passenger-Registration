import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:saud_app/shared/component/theme.dart';

  // show the dialog
showDialogMethod({
  required BuildContext context ,
  required Widget title ,
  required Widget content ,
  required Function cancelButton ,
  required String textCancel ,
  required var continueButton  ,
  required String textContinue
})
{
  return showDialog(
    context: context,
    builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: Colors.deepPurple.shade600,
          titleTextStyle: headingStyle,
          contentTextStyle: subHeadingStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),

          title: title,
          content: content,
          actions: [
            TextButton(onPressed:()
              {
                Navigator.pop(context);
              }
              , child: Text(textCancel,textAlign: TextAlign.left,
                  style:TextStyle(fontSize: 18,color: Colors.red.shade700) ),),

            TextButton(onPressed:continueButton, child: Text(textContinue , textAlign: TextAlign.right,
                style:TextStyle(fontSize: 18,color: Colors.green.shade500)
            ))
          ],
        );
    },
  );
}


