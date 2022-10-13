import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_clone_flutter_udemy/src/models/cliente.dart';

class ClientProvider {
  CollectionReference _ref;

  ClientProvider() {
    _ref = FirebaseFirestore.instance.collection('Clients');
  }

  Future<void> create(Client client) {
    String errorMessage;

    try {
      return _ref.doc(client.id).set(client.toJson());
    } catch (error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<Client> getById(String id)async{
    DocumentSnapshot document = await _ref.doc(id).get();
    Client client;
    if(document.exists){
      return client = Client.fromJson(document.data());
    }
    return null;
  }

}
