import 'package:my_doctor/constant.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  var _title;
  var _charge;
  var _description;
  var _date;
  var _month;
  var _bgColor;
  var status;

  ScheduleCard(
      this._title, this._description, this._date, this._month, this._bgColor, this._charge, this.status);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: _bgColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _date,
                  style: TextStyle(
                    color: _bgColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _month,
                  style: TextStyle(
                    color: _bgColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            _title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kTitleTextColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _description.toString(),
                style: TextStyle(
                  color: kTitleTextColor.withOpacity(0.7),
                ),
              ),
              Text(
                'Charge: $_charge',
                style: TextStyle(
                  color: kTitleTextColor.withOpacity(0.7),
                ),
              ),
              Text(
                'Status: $status',
                style: TextStyle(
                  color: status.contains("booked") ? Colors.redAccent: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
