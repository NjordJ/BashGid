import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

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
          Text('Страница с активностью'),
        ],
      ),
    );
  }
}
