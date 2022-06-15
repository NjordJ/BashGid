import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../home/data/models/places.dart';

class DetailInfoPage extends StatefulWidget {
  const DetailInfoPage({Key? key}) : super(key: key);

  @override
  State<DetailInfoPage> createState() => _DetailInfoPageState();
}

class _DetailInfoPageState extends State<DetailInfoPage> {

  double? distance = 0;

  @override
  Widget build(BuildContext context) {

    final Places _placeInfo = ModalRoute
        .of(context)!
        .settings
        .arguments as Places;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(FontAwesomeIcons.locationCrosshairs),
          onPressed: (){
            setState(() {
              _determinePosition(_placeInfo.placeGeoPoint.latitude, _placeInfo.placeGeoPoint.longitude).then((value) => distance = value);
            });
          }
        ),
        appBar: AppBar(
          title: Text(_placeInfo.placeName),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(padding: EdgeInsets.all(10), child: Text('Информация')),
                    Row(
                      children: [
                        Container(padding: EdgeInsets.all(10), child: Icon(FontAwesomeIcons.solidMap)),
                        Text(_placeInfo.placeName)
                      ],
                    ),
                    Row(
                      children: [
                        Container(padding: EdgeInsets.all(10), child: Icon(FontAwesomeIcons.mapLocationDot)),
                        Text(_placeInfo.placeAddress)
                      ],
                    ),
                    Row(
                      children: [
                        Container(padding: EdgeInsets.all(10), child: Icon(FontAwesomeIcons.businessTime)),
                        Text(_placeInfo.placeWorkingTime)
                      ],
                    ),
                    Row(
                      children: [
                        Container(padding: EdgeInsets.all(10), child: Icon(FontAwesomeIcons.list)),
                        Text(_placeInfo.placeType.join(', '))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(padding: EdgeInsets.all(10), child: Icon(FontAwesomeIcons.earthEurope)),
                        Text(_placeInfo.placeGeoPoint.latitude.toString().substring(0,6)),
                        Text(_placeInfo.placeGeoPoint.longitude.toString().substring(0,6)),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.locationDot),
                          alignment: Alignment.centerRight,
                          onPressed: () async {
                            String latitude = _placeInfo.placeGeoPoint.latitude.toString();
                            String longitude = _placeInfo.placeGeoPoint.longitude.toString();
                            String googleMapUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

                            if(await canLaunch(googleMapUrl)){
                              await launch(googleMapUrl);
                            }else{
                              SmartDialog.showToast('Не удалось открыть карту');
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(padding: EdgeInsets.all(10), child: Icon(FontAwesomeIcons.route)),
                        Text((distance!/1000).toString().substring(0,3) + ' километров')
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(padding: EdgeInsets.all(10),  child: Text('Описание')),
                    Container(padding: EdgeInsets.all(10),  child: Text(_placeInfo.placeDescription, softWrap: true,)),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Future<double?> _determinePosition(double endLatitude, double endLongitude) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
    );

    double distanceBetween = Geolocator.distanceBetween(position.latitude, position.longitude, endLatitude, endLongitude);

    // print('Current latitude: '+ position.latitude.toString());
    // print('Current latitude: '+ position.longitude.toString());
    // print('Distance : '+ distanceBetween.toString());

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return distanceBetween;
  }
}
