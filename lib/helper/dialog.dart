import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

Future<void> normalProgress(context,String title) async {
  /// Create progress dialog
  ProgressDialog pd = ProgressDialog(context: context);

  /// Set options
  /// Max and msg required
  pd.show(
    max: 100,
    msg: title,
    progressBgColor: Colors.transparent,
  );
  for (int i = 0; i <= 100; i++) {
    /// You don't need to update state, just pass the value.
    /// Only value required
    pd.update(value: i);
    i++;
    await Future.delayed(Duration(milliseconds: 50));
  }
}

Future<void> showLoaderDialog(BuildContext context,String title)async {
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text(title)),
      ],),
  );
  showDialog(barrierDismissible: true,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}