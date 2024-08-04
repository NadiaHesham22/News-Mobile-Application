import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_project/layout/NewsApp/cubit/states.dart';
import 'package:my_first_project/modules/business/business_screen.dart';
import 'package:my_first_project/modules/science/science_screen.dart';
import 'package:my_first_project/modules/settings_screen/settings_screen.dart';
import 'package:my_first_project/modules/sports/sports_screen.dart';
import 'package:my_first_project/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {

  NewsCubit(): super(NewsInitialStates());

  static NewsCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=
  [
    BottomNavigationBarItem(
      icon:Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.science,
      ),
      label: 'Science',
    ),

  ];

  List<Widget> screens=
      [
        BusinessScreen(),
        SportsScreen(),
        ScienceScreen(),

      ];



  void changeBottomNavBar(int index){
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    currentIndex=index;
    emit(NewsBottomNavStates());
  }

  List<dynamic> business=[];

  void getBusiness()
  {

    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:{
        'country':'eg',
        'category':'business',
        'apikey':'93c47f112be14485921f106d710cdf87',
      },
    ).then((value){
      //print(value.data['articles'].toString());
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    }
    );
  }

  List<dynamic> sports=[];

  void getSports()
  {
    emit(NewsGetSportsLoadingStates());

    if(sports.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'sports',
          'apikey':'93c47f112be14485921f106d710cdf87',
        },
      ).then((value){
        //print(value.data['articles'].toString());
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      }
      );
    } else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science=[];

  void getScience()
  {
    emit(NewsGetScienceLoadingStates());

    if(science.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'science',
          'apikey':'93c47f112be14485921f106d710cdf87',
        },
      ).then((value){
        //print(value.data['articles'].toString());
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      }
      );
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

  List<dynamic> search=[];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingStates());

      DioHelper.getData(
        url: 'v2/everything',
        query:{
          'q':'$value',
          'apikey':'93c47f112be14485921f106d710cdf87',
        },
      ).then((value){
        //print(value.data['articles'].toString());
        search=value.data['articles'];
        print(search[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      }
      );
      //emit(NewsGetSearchSuccessState());
  }
}