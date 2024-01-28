import 'package:flutter/material.dart';

class ConfirmationPage extends StatefulWidget {
  static const routename = "confirmationpage";
  const ConfirmationPage({super.key});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  bool sucessfull = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(192, 159, 255, 1),
        title: const Text(
          "Block Ballot",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 203, 227, 247), // Set your background color
                borderRadius:
                    BorderRadius.circular(10.0), // Set border radius if needed
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 30),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "CONFIRM",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Container(
                              constraints: BoxConstraints(maxHeight: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        !sucessfull
                                            ? "Confirm Vote ?"
                                            : "Sucessfull",
                                        style: sucessfull
                                            ? const TextStyle(
                                                fontSize: 30,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              )
                                            : const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  if (!sucessfull)
                                    ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            sucessfull = true;
                                          });
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          Navigator.of(context).pop();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "vote",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSucess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          constraints: BoxConstraints(maxHeight: 100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Successfull",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
