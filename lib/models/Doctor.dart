class Doctor{
  String name, specialization, phone, image, hospital, doctorId, about;

  
  Doctor({this.name, this.specialization, this.phone, this.image, this.about, this.doctorId, this.hospital});
  
  factory Doctor.fromJson(Map<dynamic, dynamic> json)=> doctorFromJson(json);
}

Doctor doctorFromJson(Map<dynamic, dynamic> json){
  return Doctor(
    name: json['name'] as String,
    specialization: json['specialization'] as String,
    phone: json['phone'] as String,
    image: json['image'] as String,
    hospital: json['hospital'] as String,
    doctorId: json['doctor_id'] as String,
    about: json['about'] as String,
  );
}