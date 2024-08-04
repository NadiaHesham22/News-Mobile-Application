import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_project/layout/NewsApp/cubit/cubit.dart';
import 'package:my_first_project/layout/NewsApp/cubit/states.dart';
import 'package:my_first_project/shared/components/components.dart';

class SearchScreen extends StatelessWidget {


  //const SearchScreen({super.key});

  @override
  var searchController=TextEditingController();
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value){
                    if(value!.isEmpty){
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch:true)),
            ],
          ),
        );
      },

    );
  }
}
