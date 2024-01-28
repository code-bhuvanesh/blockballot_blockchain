import 'package:blockballot/features/confirmation_page/confirmation_page.dart';
import 'package:flutter/material.dart';

import 'candidate_widget.dart';

class VotersPage extends StatefulWidget {
  static const routename = "voterspage";
  const VotersPage({super.key});

  @override
  State<VotersPage> createState() => _VotersPageState();
}

class _VotersPageState extends State<VotersPage> {
  List posts = ["BPJ", "AKMD", "MKD", "JPR", "SAT"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromRGBO(157, 109, 247, 1),
            title: const Text(
              "Block Ballot",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
        body: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 19,
                  bottom: 14,
                ),
                child: Text(
                  "Select Candiate",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return CandidateWidget(
                    passing: posts[index],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
