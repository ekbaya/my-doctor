import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Loader{
  BuildContext context;
  ProgressDialog pr;
  Loader(this.context){
    pr = new ProgressDialog(context);
    //For normal dialog
  }

  void showDialogue(String message){
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    pr.show();
  }

  void hideDialogue(){
    pr.hide();
  }
}