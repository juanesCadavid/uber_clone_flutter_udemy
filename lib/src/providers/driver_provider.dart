import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone_flutter_udemy/src/models/driver.dart';

class DriverProvider {
  CollectionReference _ref;

  DriverProvider() {
    _ref = FirebaseFirestore.instance.collection('Drivers');
  }

  Future<void> create(Driver driver) {
    String errorMessage;

    try {
      return _ref.doc(driver.id).set(driver.toJson());
    } catch (error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<Driver> getById(String id)async{
    DocumentSnapshot document = await _ref.doc(id).get();
    Driver driver;
    if(document.exists){
      return driver = Driver.fromJson(document.data());
    }
    return null;
  }
}
