class Appointment{
  String day, month, year, doctorId, userId, description, charge, status, name, id, scheduleId, doctorName;

  Appointment({this.day, this.month, this.year, this.doctorId, this.userId, this.description, this.charge, this.name, this.status, this.id, this.scheduleId, this.doctorName});

  factory Appointment.fromJson(Map<dynamic, dynamic> json)=> appointmentFromJson(json);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
      'day': day,
      'userId': userId,
      'doctorId':doctorId,
      'description':description,
      'year':year,
      'month':month,
      'charge':charge,
      'status':status,
      'name':name,
      'id':id,
      'schedule_id':scheduleId,
      'doctor_name':doctorName
    };



}

Appointment appointmentFromJson(Map<dynamic, dynamic> json){
  return Appointment(
    day: json['day'] as String,
    userId: json['userId'] as String,
    doctorId: json['doctorId'] as String,
    description: json['description'] as String,
    year: json['year'] as String,
    month: json['month'] as String,
    charge: json['charge'] as String,
    status: json['status'] as String,
    name: json['name'] as String,
    id: json['id'] as String,
    scheduleId: json['schedule_id'] as String,
    doctorName: json['doctor_name'] as String
  );
}