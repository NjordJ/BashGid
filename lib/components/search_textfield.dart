import 'package:bash_gid/components/bottom_sheet_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/authorization.dart';
import '../core/database.dart';

final DataBaseService _dataBaseService = DataBaseService();

Widget _searchTextField(BuildContext context, Icon icon, String hint, TextEditingController controller, bool obscure, searchFunc, filterPageFunc, logOutFunc){
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: null,
        style: const TextStyle(fontSize: 20, color: Colors.black,),
        decoration: InputDecoration(
            fillColor: const Color.fromRGBO(144, 188, 218, 1.0),
            filled: true,
            hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
            hintText: hint,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 3,
                )
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                  width: 1,
                )
            ),
            prefixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: const Icon(Icons.menu),
                    iconSize: 25,
                    color: Colors.black54,
                    onPressed: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context)
                          {
                            //second parameter: widget.user.email!
                            //return bottomSheetMenu(context, 'widget.user.email!', (){}, (){}, logOutFunc);
                            return Container();
                          });
                    }),
                IconButton(
                    icon: const Icon(FontAwesomeIcons.filter),
                    iconSize: 25,
                    color: Colors.black54,
                    onPressed: (){
                      filterPageFunc;
                    }),
              ],
            ),
            suffixIcon: Container(
              //padding: EdgeInsets.only(left: 10, right: 10),
              child: IconButton(
                icon: icon,
                iconSize: 25,
                color: Colors.black54,
                onPressed: (){
                  // TODO: Implement search logic

                  _dataBaseService.getPlacesSights();

                  // showModalBottomSheet(
                  //     context: context,
                  //     builder: (context)
                  //     {
                  //       return indexCurrentNavBar == 0 ? bottomSheetItems(context, _sightPlaces, _filterPageRedirect) :
                  //       (indexCurrentNavBar == 1) ? bottomSheetItems(context, _hotelPlaces, (){}) : bottomSheetItems(context, _foodPlaces, (){});
                  //     });
                },
              ),
            )
        ),
      ),
    ),
  );
}

