import 'package:finandy/constants/texts.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar(){
    return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              CircleAvatar(
               radius: 12,
               foregroundImage: NetworkImage(userImg),
               ),
             Text("$wlcm, $userName", style: const TextStyle(
                fontSize: 18
               ),
               overflow: TextOverflow.fade,
             )
           ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size(30, 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.white,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Chattarpur", 
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Text("New Delhi",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: const Icon(Icons.confirmation_num_outlined)
              ),
            IconButton(
              onPressed: (){},
              icon: const Icon(Icons.notifications_none_sharp)
              )  
          ],
      );
  }