class Schedule{
  String name, description, scheduleID, date, month, year, charge, status;

  Schedule({this.name, this.description, this.scheduleID, this.date, this.month, this.year, this.charge, this.status});
  
  factory Schedule.fromJson(Map<dynamic, dynamic> json)=> scheduleFromJson(json);
}

Schedule scheduleFromJson(Map<dynamic, dynamic> json){
  return Schedule(
    name: json['name'] as String,
    description: json['description'] as String,
    scheduleID: json['schedule_id'] as String,
    date: json['date'] as String,
    year: json['year'] as String,
    month: json['month'] as String,
    charge: json['charge'] as String,
    status: json['status'] as String,
  );
}