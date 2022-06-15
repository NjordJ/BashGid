import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../features/home/data/models/places.dart';

class DataBaseService{
  final _placeSightCollection = FirebaseFirestore.instance.collection('places_sight');
  final _placeHotelCollection = FirebaseFirestore.instance.collection('places_hotels');
  final _placeFoodCollection = FirebaseFirestore.instance.collection('places_food');

  final FirebaseStorage storage = FirebaseStorage.instance;

  //Stream methods
  Stream<List<Places>> getAllPlacesSight(){
    return _placeSightCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) =>
        Places.fromJson(doc.data())).toList());
  }

  Stream<List<Places>> getAllPlacesHotels(){
    return _placeHotelCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) =>
            Places.fromJson(doc.data())).toList());
  }

  Stream<List<Places>> getAllPlacesFood(){
    return _placeFoodCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) =>
            Places.fromJson(doc.data())).toList());
  }

  //Future methods
  Future<String> getPhotos(String imageName) async {
    String downloadUrl = await storage.ref(imageName).getDownloadURL();
    //print('Image URL: ' + downloadUrl);
    return downloadUrl;
  }

  Future<List<Places>> getPlacesSights() async {
    List<Places> places = [];
    QuerySnapshot querySnapshot = await _placeSightCollection.get();

    // Get data from docs and convert map to List
    places = querySnapshot.docs.map((doc) =>
        Places.fromJson(doc.data() as Map<String, dynamic>)).toList();

    //for a specific field
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();

    //print(allData);
    return places;
  }

  Future<List<Places>> getPlacesHotels() async {
    List<Places> places = [];
    QuerySnapshot querySnapshot = await _placeHotelCollection.get();

    // Get data from docs and convert map to List
    places = querySnapshot.docs.map((doc) =>
        Places.fromJson(doc.data() as Map<String, dynamic>)).toList();

    return places;
  }

  Future<List<Places>> getPlacesFoods() async {
    List<Places> places = [];
    QuerySnapshot querySnapshot = await _placeFoodCollection.get();

    // Get data from docs and convert map to List
    places = querySnapshot.docs.map((doc) =>
        Places.fromJson(doc.data() as Map<String, dynamic>)).toList();

    return places;
  }

}