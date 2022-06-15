import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget bottomSheetMenu(BuildContext context, userEmailOrUserName, void funcSettings(), void funcInformation(), void funcLogOut(), void funcActivity()) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        //Color with opacity zero
        color: Color(0xFF737373),
        //height: MediaQuery.of(context).viewInsets.bottom,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: Column(
              children: <Widget>[
                //Decoration at top of sheet menu
                Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width/7,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('Здравствуйте, ' + userEmailOrUserName)
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.clockRotateLeft),
                  title: Text('История'),
                  onTap: funcActivity,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Настройки'),
                  onTap: funcSettings,
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Информация'),
                  onTap: funcInformation,
                ),
                Divider(
                  color: Colors.black,
                  height: 3,
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Выйти'),
                  onTap: funcLogOut,
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

