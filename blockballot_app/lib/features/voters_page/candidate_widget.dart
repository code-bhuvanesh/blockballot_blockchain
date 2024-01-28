import 'package:flutter/material.dart';

import '../confirmation_page/confirmation_page.dart';

class CandidateWidget extends StatelessWidget {
  // const MySquare({super.key});
  final String passing;
  CandidateWidget({required this.passing});

  var imgurl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/TamilNadu_Logo.svg/300px-TamilNadu_Logo.svg.png";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).pushNamed(ConfirmationPage.routename),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepPurple,
        ),
        margin: const EdgeInsets.all(10),
        height: 300,
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  height: 200,
                  child: Image.network(
                    imgurl,
                    height: 100,
                  ),
                ),
              ),
            ),
            // Image(image: context),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              passing,
              style: TextStyle(
                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
