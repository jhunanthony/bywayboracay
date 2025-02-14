import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

/// Example event class.
class Event {
  final String title;
  final List users;
  final String desc;
  final String timer; 
  final String budget;
  final String website;
  final String imgName;
  final String lat;
  final String long;
    final String address;
      final String itemname;
  final String category;
  final String creator;
  const Event(this.title, this.users, this.desc, this.timer, this.budget, this.website,this.imgName, this.lat, this.long, this.address, this.itemname, this.category, this.creator,);

  @override
  String toString() => title;
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, 1, 1);
final kLastDay = DateTime(kNow.year + 3, 1, 1);

abstract class Functions {
  Future sendEmail(String s, String d, String t, String u);
  Future<List> eventUsers(List w);
  int calculateDifference(DateTime date);
}

class FunctionUtils implements Functions {
  final databaseRef = FirebaseFirestore.instance
      .collection("Users")
      .doc(Auth().getCurrentUser().uid)
      .get();


  //edit this
  Future sendEmail(String s, String d, String t, String u) async {
    final user = await Auth().signInWithGoogle();
    if (user == null) return;
    final email = user.email;
    
    final token = user.getIdToken().toString();

    //String password = 'Tourplanner2k21';
    final smtpServer = gmailSaslXoauth2(email, token);
    // Create our message.
    final message = Message()
      ..from = Address(email, 'Byway Boracay App')
      ..recipients.add(s)
      ..subject = 'Event Reminder :: Date :: $d'
      ..html =
          "<h1>Reminder</h1>\n<p>This is to remind you to attend the event scheduled $u at time $t .</p>";
    try {
      final sendReport = await send(message, smtpServer);
      showSimpleNotification(Text("Email Successfully Sent !!"),
          background: Color(0xff29a39d));
      print(sendReport);
    } on MailerException catch (e) {
      showSimpleNotification(Text(e.toString() + ' not sent'),
          background: Color(0xff29a39d));
    }
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  Future<List> eventUsers(List w) async {
    List temp = [];
    final users = await FirebaseFirestore.instance.collection("Users").get();
    for (int i = 0; i < users.docs.length; i++) {
      var t = users.docs[i].get("Email");
      if (w.contains(t)) {
        temp.add(users.docs[i].id);
      }
    }
    return temp;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
