import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/web_view_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget buildArticleItem(articles, context) => InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(articles['url']),);
  },
  child:   Padding(















    padding: const EdgeInsets.all(20.0),















    child: Row(















      children:















      [















        Container(















          width: 120,















          height: 120,















          decoration: BoxDecoration(















            borderRadius: BorderRadius.circular(10.0,),















            image:  DecorationImage(















              image: NetworkImage('${articles['urlToImage']}'),















              fit: BoxFit.cover,















            ),















          ),















        ),















        const SizedBox(















          width: 20,















        ),















        Expanded(















          child: Container(















            width: 120,















            height: 120,















            child: Column(















              mainAxisSize: MainAxisSize.min,















              mainAxisAlignment: MainAxisAlignment.start,















              crossAxisAlignment: CrossAxisAlignment.start,















              children:  [















                Expanded(















                  child: Text(















                    '${articles['title']}',















                    maxLines: 3,















                    overflow: TextOverflow.ellipsis,















                    style: Theme.of(context).textTheme.bodyText1,















                  ),















                ),















                Text(















                  '${articles['publishedAt']}',















                  style: TextStyle(















                    color: Colors.grey,















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

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    width: double.infinity,
    height: 2.0,
    color: Colors.grey[300],
  ),
);

Widget ArticleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword=false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  VoidCallback? OnTap,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: (s){
    onSubmit!();
  },
  onChanged: (s){
    onChange!(s);
  },
  onTap: OnTap,
  validator: (s){
    validate(s);
    //return validate(s);
  },
  decoration:  InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix !=null ?  IconButton(
      icon: Icon(
        suffix,
      ),
      onPressed: (){
        suffixPressed!();
      },

    ) : null,
    border: OutlineInputBorder(),
  ),
);


void navigateTo(context,widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
);