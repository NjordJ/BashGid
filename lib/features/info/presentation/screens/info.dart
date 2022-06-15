import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  final _whatsNewTitle = 'Новое';
  final _whatsNewDescription = '1. Появились фильтры\n2. Появилась вкладка историй';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        //toolbarHeight: 15,
        title: const Text('Информация'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          const ListTile(
            title: Text('Версия'),
            subtitle: Text('Beta 0.0.1'),
          ),
          ListTile(
            title: TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(_whatsNewTitle),
                  content: Text(_whatsNewDescription),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text('Что нового'),
            ),
          )
        ],
      ),
    );
  }
}
