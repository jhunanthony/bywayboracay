import 'package:bywayborcay/widgets/Navigation/TopNavBar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopNavBar(
        colorbackground: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "About Us",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 10),
            Image.asset(
              "assets/images/Logo_Test.png",
              height: 35,
              width: 35,
              fit: BoxFit.scaleDown,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "       Welcome to Byway Boracay, your number one travel buddy when visiting boracay! We're dedicated to giving you the very best tour planner planner app, with a focus on flexibility, budget management, communication, and navigation. Developed in year 2022 by a group of Information Technology students from Aklan, Byway Boracay is a product of a capstone project. Our passion for contributing to the economic growth of Boracay Island drove us to do intensive research and the development of an Android-based Mobile Application which helps promote and sustain tourism in the island.\n\n We hope you enjoy our app as much as we enjoy offering it to you. If you have any questions or comments, please don't hesitate to contact us.\n\nSincerely, Byway Boracay team",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            TextButton(
                onPressed: () async {
                  String mailto = "mailto:" +
                      "bywayboracay@gmail.com" +
                      "?subject=Inquiry&body=Greetings!";
                  if (await canLaunch(mailto)) {
                    await launch(mailto);
                  } else {
                    throw 'Could not launch $mailto';
                  }
                },
                child: Text(
                  "bywayboracay@gmail.com",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                )),
            TextButton(
                onPressed: () async {
                  String mailto = "mailto:" +
                      "bywayboracay2k21@gmail.com" +
                      "?subject=Inquiry&body=Greetings!";
                  if (await canLaunch(mailto)) {
                    await launch(mailto);
                  } else {
                    throw 'Could not launch $mailto';
                  }
                },
                child: Text(
                  "bywayboracay2k21@gmail.com",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
