import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
import '../../shared/component/component.dart';
import '../../shared/component/theme.dart';

class PeofileScreen extends StatelessWidget {
  const PeofileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Uri toLaunch = Uri(scheme: 'https', host: 'github.com', path: 'Mahmoud-M-Fouad');
     String pasteValue='';
    return Scaffold(
      appBar: AppBar(
        title: Text("Emad M El Samery",style: headingStyle,),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurple.shade500,
      body: SafeArea(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.,
              children: [
                buildImageProfile(
                  imagePath:'image/profile.jpg',
                  radius: 100,
                ),
                const SizedBox(height: 20,),
                Text("Mobile Developer",style: headingStyle,),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    makePhoneCall(phoneNumber: "01063378834");
                  },
                  onLongPress: ()
                  {
                    buildCopy(textCopy: "01063378834", context: context);
                  },
                  child: buildColumnShow(
                      icon: Icons.phone, list: "01063378834"),
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    makeMail(mail: "alsmryemad82@gmail.com");
                  },
                  onLongPress: ()
                  {
                    buildCopy(textCopy: "alsmryemad82@gmail.com", context: context);
                  },
                  child: buildColumnShow(
                      icon: Icons.mail, list: "alsmryemad82@gmail.com"),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          toLaunch = Uri(scheme: 'https', host: 'facebook.com', path: 'profile.php?id=100008683122059');
                          launchInBrowser(
                            url: toLaunch,//"https://github.com/Mahmoud-M-Fouad",
                              //https://www.facebook.com/profile.php?id=100008683122059
                          );
                        },
                        child:const ImageIcon(
                          AssetImage("image/face.png"),
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          toLaunch = Uri(scheme: 'https', host: 'github.com', path: 'Mahmoud-M-Fouad');
                          launchInBrowser(
                            url: toLaunch,//"https://github.com/Mahmoud-M-Fouad",

                          );
                        },
                        child:const ImageIcon(
                          AssetImage("image/github.png"),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )

              ],
          ),
        ),
      ),
    );
  }

  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  Future<void> makeMail({required String mail}) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: mail,
    );
    await launchUrl(launchUri);
  }
  Future<void> launchInBrowser({required Uri url}) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
  buildColumnShow({required IconData icon, required var list}) {
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
        const SizedBox(width: 20,),
        Icon(
          icon,
          color: Colors.yellowAccent.shade700,
        ),
      ],
    );
  }
}
