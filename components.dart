import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_first_project/modules/webView/web_view_screen.dart';
import 'package:my_first_project/shared/cubit/cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChanged,
  VoidCallback? onTap,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
   IconData? suffix,
  bool isClickable=true,
  VoidCallback? suffixPressed,
})=> TextFormField(
controller: controller,
keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  onTap:onTap ,
  enabled: isClickable,
  decoration: InputDecoration(
    labelText:label,
    prefixIcon: Icon(
      prefix,
    ),
    border: OutlineInputBorder(),
    // suffix: Icon(
    //  suffix,
    // ),
    suffixIcon:  GestureDetector(
      onTap: suffixPressed,
      child: Icon(suffix),
    ) ,
  ),


);

Widget buildTaskItem(Map model,context)=> Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
            [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(onPressed: (){
        AppCubit.get(context).UpdateData(status: 'Done',
            id: model['id'],
        );
        },
          icon:Icon(
              Icons.check_box,
            color:Colors.green,
          ) ,
        ),
        IconButton(onPressed: (){
          AppCubit.get(context).UpdateData(status: 'Archive',
            id: model['id'],
          );
        },
          icon:Icon(
              Icons.archive,
            color: Colors.black45,
          ) ,
        ),

      ],
    ),
  ),
  onDismissed: (direction){
   AppCubit.get(context).DeleteData(id: model['id'],);
  },
);

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
    navigatetTo(context, WebViewScreen(article['url']),);
  },
  child: Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
  children:
  [
  Container(
  width: 120.0,
  height: 120.0,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10.0,),
  image: DecorationImage(
  image: NetworkImage('${article['urlToImage']}'),
  fit: BoxFit.cover,
  ),
  ),
  ),
  SizedBox(
  width: 20.0,
  ),
  Expanded(
  child: Container(
  height: 120.0,
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
  Expanded(
  child: Text(
  '${article['title']}',
  maxLines: 3,
  overflow: TextOverflow.ellipsis,
  style: Theme.of(context).textTheme.bodyText1,
  ),
  ),
  Text(
  '${article['publishedAt']}',
  style: TextStyle(
  color:Colors.grey,
  ),
  ),

  ],
  ),
  ),
  ),
  ],
  ),
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void navigatetTo(context,widget)=>Navigator.push(context,
  MaterialPageRoute(
    builder:(context)=>widget,
  ),
);

Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=>myDivider(),
    itemCount: 10,
  ),
  fallback: (context)=>isSearch? Container(): Center(child: CircularProgressIndicator()),
);

void navigateAndfinish(
    context,
    Widget,
    )=>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context)=>Widget,
      ),
          (Route<dynamic>route) => false,
    );

 Widget defaultButton({
  required  VoidCallback function,
   required String text,
   MaterialColor? color,
})=> Container(
   width: double.infinity,
   color: color,
   child: MaterialButton(
     onPressed: function,
     child: Text(
       text,
       style: TextStyle(
         fontSize: 20.0,
         color: Colors.white,
       ),
     ),
   ),
 );

 Widget defaultTextButton({
   required VoidCallback? function,
   required String text,
})=> TextButton(
   onPressed:function,
   child: Text(
      text.toUpperCase() ),
 );