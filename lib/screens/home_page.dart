import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

import '../cubit/AppCubit.dart';
import '../cubit/AppStates.dart';
import 'buisness_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  List<String> titles=[
    "Business Screen",
    "Sports screen",
    "Science screen",
  ];
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){},
          builder: (context, state) {
            List<Widget> screens=[
              BusinessScreen(news: AppCubit.get(context).businessNews,),
              SportsScreen(news: AppCubit.get(context).sportsNews,),
              ScienceScreen(news: AppCubit.get(context).scienceNews,),
            ];
            return Scaffold(
            appBar: AppBar(
              actions: [
               const SizedBox(width: 50,),
                IconButton(
                  onPressed: (){
                    AppCubit.get(context).isDarkMode(context: context);
                },
                    icon: const Icon(Icons.brightness_4,size: 50,color: Colors.orange,),
                ),
              ],
              title: Text(titles[AppCubit.get(context).currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index)
              {
                AppCubit.get(context).setCurrentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.business_center),
                    label: "Business",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.sports_basketball),
                    label: "Sports",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.science_outlined),
                    label: "Science",
                ),
              ],
            ),
            body: screens[AppCubit.get(context).currentIndex],
          );});
  }
}