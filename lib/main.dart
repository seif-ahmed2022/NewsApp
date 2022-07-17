import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/shared/local/cash_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';

import 'cubit/AppCubit.dart';
import 'cubit/AppStates.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  bool isDark=CashHelper.getData(key: "isDark", def: false);
  runApp( MyApp(isDark:isDark,));
}

class MyApp extends StatelessWidget {
   MyApp({Key? key,required this.isDark}) : super(key: key);
  bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( context)=>AppCubit()
        ..getBusinessNews()
        ..getScienceNews()
        ..getSportsNews()..isDarkMode(context: context, fromShared: isDark),
        child:BlocConsumer<AppCubit,AppStates>(
          listener: (context, state) {},
          builder: (context, state)=>MaterialApp(
           title: 'flutter Demo',
           theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
           appBarTheme: const AppBarTheme(
             systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
           elevation: 0,
           // centerTitle: true,
            ),
             bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.orange,
           ),
             primarySwatch: Colors.blue,
            ),

           themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            darkTheme: ThemeData(
             scaffoldBackgroundColor: Colors.grey,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                color: Colors.black,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0,
                // centerTitle: true,
              ),
             // textTheme: const TextTheme(
               // bodyText1: TextStyle(
                 // color:Colors.white,
                //),
             // ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.orange,
              ),
            ),

            home:  HomeScreen(),
             debugShowCheckedModeBanner: false,
     ),
          ),
        );
  }
}