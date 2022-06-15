import 'package:flutter/material.dart';

import '../../../home/data/models/places.dart';
import '../../data/models/filters.dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);

  final List<Filters> _sightFiltersList = [
    Filters(filterName: 'Национальный парк', filterState: false),
    Filters(filterName: 'Памятник', filterState: false),
    Filters(filterName: 'Место исторического события', filterState: false),
    Filters(filterName: 'Зоопарк', filterState: false),
    Filters(filterName: 'Музей', filterState: false),
    Filters(filterName: 'Галлерея', filterState: true),
    Filters(filterName: 'Ботанический сад', filterState: false),
    Filters(filterName: 'Парк развлечений', filterState: false),
    Filters(filterName: 'Культурное событие', filterState: true),
    Filters(filterName: 'Карнавал', filterState: false),
    Filters(filterName: 'Ярмарка', filterState: false),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Фильтры'),
        actions: [
          TextButton(
              onPressed: (){},
              child: const Text('Сбросить')
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Категории'),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Expanded(
              child: ListView.builder(
                itemCount: _sightFiltersList.length,
                  itemBuilder: (context, index){
                    return Row(
                      children: [
                        Text(_sightFiltersList[index].filterName),
                        const Spacer(),
                        Checkbox(value: _sightFiltersList[index].filterState, onChanged: null),
                      ],
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}