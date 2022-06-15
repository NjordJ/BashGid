import 'package:bash_gid/features/item_detail_info/presentation/screens/detail_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../features/home/data/models/places.dart';


Widget listPlaces(String image, String howFarPlace, List<Places> places) {
  return  Expanded(
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5
      ),
      itemCount: places.length,
      itemBuilder: (context, index){
        return Container(
          alignment: Alignment.center,
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailInfoPage(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(
                    arguments: places[index],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2.0,
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', height: 150, width: 150,),
                  Spacer(),
                  Text(places[index].placeName),
                  Text('100km'),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

