import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_project/layout/NewsApp/cubit/cubit.dart';
import 'package:my_first_project/layout/NewsApp/cubit/states.dart';
import 'package:my_first_project/modules/search/search_screen.dart';
import 'package:my_first_project/shared/components/components.dart';
import 'package:my_first_project/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: ( context,  state) {
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(onPressed: (){
                navigatetTo(context, SearchScreen(),);
              },
                icon: Icon(
                    Icons.search
                ),
              ),
              IconButton(onPressed: (){
                AppCubit.get(context).changeMode();
              },
                icon: Icon(
                    Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
             onTap: (index)
             {
               cubit.changeBottomNavBar(index);
             },
             items:cubit.bottomItems,
          ),
          );
      },
    );
  }
}
