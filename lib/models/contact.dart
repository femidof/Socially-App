import 'package:cloud_firestore/cloud_firestore.dart';

// import 'user.dart';

class Contact {
  String uid;
  Timestamp addedOn;
  Timestamp last_message_at;

  Contact({
    this.uid,
    this.addedOn,
  });

  Map toMap(Contact contact) {
    var data = Map<String, dynamic>();
    data['contact_id'] = contact.uid;
    data['added_on'] = contact.addedOn;
    data['last_message_at'] = Timestamp.now();
    return data;
  }

  Contact.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['contact_id'];
    this.addedOn = mapData['added_on'];
    this.last_message_at = mapData['last_message_at'];
  }
}
