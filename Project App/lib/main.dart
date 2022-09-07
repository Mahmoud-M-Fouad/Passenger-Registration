import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saud_app/shared/component/db.dart';
import 'package:saud_app/shared/cubit/cubit_app.dart';
import 'package:saud_app/shared/cubit/cubit_states.dart';
import 'package:saud_app/shared/shared_preferences/shared_preferences.dart';

import 'layout/home_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  createDatabase();
  await SharedClass.inti();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return  MaterialApp(

              title: "تسجيل المسافرين",
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,

                  appBarTheme:const AppBarTheme(
                    color:  Colors.deepPurple,
                    elevation: 0,
                  )
                ),
              debugShowCheckedModeBanner: false,
              home: const HomeScreen(),
              color: Colors.deepPurple,
              /*
              localizationsDelegates: [

                AppLocale.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate

              ],
              supportedLocales: const [
                Locale("en", ""),
                Locale("ar", ""),
              ],

              localeResolutionCallback: (currentLang, supportLang) {
                if (currentLang != null) {
                  for (Locale locale in supportLang) {
                    if (locale.languageCode == currentLang.languageCode) {
                      SharedClass.setlang(key: "lang" , num: currentLang.languageCode) ;
                      return currentLang;

                    }
                  }
                }
                return supportLang.first;
              },

              */
            );
          },
        ));
  }
}

