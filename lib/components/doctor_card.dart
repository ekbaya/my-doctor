import 'package:my_doctor/constant.dart';
import 'package:my_doctor/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  var _name;
  var _description;
  var _imageUrl;
  var _bgColor;
  var doctor_id;

  DoctorCard(this._name, this._description, this._imageUrl, this._bgColor, this.doctor_id);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(_name, _description, _imageUrl, doctor_id),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.network(_imageUrl),
            title: Text(
              _name,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 13
              ),
            ),
            subtitle: Text(
              _description,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
