import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_project/layout/NewsApp/cubit/cubit.dart';
import 'package:my_first_project/layout/NewsApp/cubit/states.dart';
import 'package:my_first_project/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var lists =NewsCubit.get(context).business;
        return  ConditionalBuilder(
          condition: state is ! NewsGetBusinessLoadingStates,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildArticleItem(lists[index],context),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              itemCount:10,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
}
