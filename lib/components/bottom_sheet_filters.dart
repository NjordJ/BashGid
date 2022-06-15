import 'package:bash_gid/features/home/data/models/places.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../features/filter/data/models/filters.dart';

Widget _bottomSheetFilters(BuildContext context, List<Filters> list) {
  return Container(
    color: const Color(0xFF737373),
    child: Container(
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              height: 5,
              width: MediaQuery.of(context).size.width/7,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              TextButton(
                  onPressed: (){
                    for(var place in list){
                      place.filterState = false;
                    }
                  },
                  child: const Text('Сбросить')
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        decoration: const BoxDecoration(color: Color.fromRGBO(144, 188, 218, 1.0)),
                        child: Row(
                          children: [
                            Text(list[index].filterName),
                            const Spacer(),
                            //Checkbox(value: list[index].filterState, onChanged: null),
                            Switch.adaptive(value: list[index].filterState, onChanged: null),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

