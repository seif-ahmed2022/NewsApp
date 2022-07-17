import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../shared/local/cash_helper.dart';
import '../shared/local/constant.dart';
import '../shared/network/dio_helper.dart';
import 'AppStates.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(BuildContext context)=>BlocProvider.of(context);

  List businessNews=[];
  List scienceNews=[];
  List sportsNews=[];

  int currentIndex=0;

  void setCurrentIndex(index){
    currentIndex=index;
    emit(SetCurrentIndexState());
  }

  bool isDark=false;
  void isDarkMode({bool? fromShared, required BuildContext context}){
    if(fromShared !=null){
      isDark=fromShared;
    }else{
      isDark=!isDark;
      CashHelper.saveData(key: "isDark", value: AppCubit.get(context).isDark);
    }
    emit(ChangeModeState());

  }

  void getBusinessNews(){
    emit(GetBusinessLoadingState());
    DioHelper.getData(
        url: "v2/top-headlines",
        query: {
      //=country=us&category=business&=
      "country":"eg",
      "category":"business",
      "apiKey":"d293df47f5924ee2b9a9a833af438640",
    }).then((value) {
      businessNews=value.data["articles"];
      emit(GetBusinessSuccessState());
     // print(businessNews[0]["title"]);
      //print(businessNews.length);

    }).catchError((error){
      emit(GetBusinessErrorState());
      print(error.toString());
    });
  }

  void getScienceNews(){
    emit(GetScienceLoadingState());
    DioHelper.getData(
        url: "v2/top-headlines",
        query: {
      //=country=us&category=business&=
      "country":"eg",
      "category":"science",
      "apiKey":"d293df47f5924ee2b9a9a833af438640",
    }).then((value) {
      scienceNews=value.data["articles"];
      emit(GetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetScienceErrorState());
    });
  }

  void getSportsNews(){
    emit(GetSportsLoadingState());
    DioHelper.getData(
        url: "v2/top-headlines",
        query: {
      //=country=us&category=business&=
      "country":"eg",
      "category":"sports",
      "apiKey":"d293df47f5924ee2b9a9a833af438640",
    }).then((value) {
      emit(GetSportsSuccessState());
      sportsNews=value.data["articles"];

    }).catchError((error){
      emit(GetSportsErrorState());
      print(error.toString());
    });
  }

}