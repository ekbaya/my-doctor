import 'package:firebase_database/firebase_database.dart';

class User{
  String id, email, image, name, nationalId, phone;

  User({this.id, this.email, this.image, this.name, this.nationalId, this.phone});

  factory User.fromSnapshot(DataSnapshot snapshot)=>userFromSnapshot(snapshot);
}

User userFromSnapshot(DataSnapshot snapshot){
  return User(
    id: snapshot.value['id'],
    email: snapshot.value['email'],
    image: snapshot.value['image'],
    name: snapshot.value['name'],
    nationalId: snapshot.value['nationalId'],
    phone: snapshot.value['phone']
  );
}