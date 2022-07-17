import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/web_view_screens.dart';

class NewsItem extends StatelessWidget {
   NewsItem({Key? key, required this.news,}) : super(key: key);

   Map news;

  @override
  Widget build(BuildContext context, ) {                  //Map itemData
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => WebViewScreen(
            url:news["url"]),
          ),
          );
        },
        child: Row(
          children: [
                Expanded(
                  flex: 1,
                    child: Image.network(
                      news["urlToImage"]??"https://vid.alarabiya.net/images/2022/06/03/9a779629-dd73-4ef9-8e1c-23252aa609da/9a779629-dd73-4ef9-8e1c-23252aa609da_16x9_600x338.jpg",
                    //https://vid.alarabiya.net/images/2022/06/03/9a779629-dd73-4ef9-8e1c-23252aa609da/9a779629-dd73-4ef9-8e1c-23252aa609da_16x9_600x338.jpg
                    fit:BoxFit.cover,
                      errorBuilder: (BuildContext context, Object object, StackTrace? stackTrace)
                      {
                        return Icon(Icons.image_not_supported_outlined,size:100,);
                      },
                    ),
                ),
            const SizedBox(width: 20,),
            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(news["title"],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,),
                ),
              const SizedBox(height: 15,),
               Text(news["publishedAt"],
                 maxLines:3,
                 style: const TextStyle(fontSize: 20,color: Colors.black,),
               ),
              ],
            ),
    ),
          ],
        ),
      ),
    );
  }
}