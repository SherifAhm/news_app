import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../modules/settings_screen/settings_screen.dart';
import '../network/remote/dio_helper.dart';




class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science',
    ),

  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0)
    {
      DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'afbe8e9661b54804a4bd73d3367c0bfa',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSucessState());

      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }
    else
    {
      emit(NewsGetBusinessSucessState());
    }

  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetBusinessLoadingState());
    if(sports.length == 0)
    {
      DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'afbe8e9661b54804a4bd73d3367c0bfa',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSucessState());

      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else
    {
      emit(NewsGetSportsSucessState());
    }

  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetBusinessLoadingState());
    if (science.length == 0)
    {
      DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'afbe8e9661b54804a4bd73d3367c0bfa',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSucessState());

      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else
    {
      emit(NewsGetScienceSucessState());
    }

  }


  List<dynamic> search = [];

  void getSearch(value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getDate(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'afbe8e9661b54804a4bd73d3367c0bfa',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSucessState());

    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}