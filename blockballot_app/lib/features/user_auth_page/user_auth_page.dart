import 'package:blockballot/features/camera_page/camera_page.dart';
import 'package:blockballot/features/voters_page/voters_page.dart';
import 'package:flutter/material.dart';

class UserAuthPage extends StatefulWidget {
  static const routename = "userAuth";
  const UserAuthPage({super.key});

  @override
  State<UserAuthPage> createState() => _UserAuthPageState();
}

class _UserAuthPageState extends State<UserAuthPage> {
  var aadharController = TextEditingController();
  var voterIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(157, 109, 247, 1),
          title: const Text(
            "Block Ballot",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Aadhar id: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              textofield(
                hint: "enter aadhar id",
                controller: aadharController,
              ),
              const Text(
                'Enter Voter id: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              textofield(
                hint: "enter voter id",
                controller: voterIdController,
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (voterIdController.text.isNotEmpty &&
                            aadharController.text.isNotEmpty) {
                          Navigator.of(context).pushNamed(CameraPage.routename);
                        }
                      },
                      child: const Text("Verify")))
            ],
          ),
        ),
      ),
    );
  }

  Column textofield({
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5), offset: Offset(2, 5)),
            ],
          ),
          margin: const EdgeInsets.only(bottom: 30, top: 10),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 135, 157, 255),
                contentPadding: const EdgeInsets.all(20),
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 134, 110, 110), fontSize: 17),
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   // child: SvgPicture.asset(
                //   //     'assests/icons/arrow-left-5-svgrepo-com.svg'),
                //   child: Icon(Icons.camera_alt_outlined),
                // ),
                suffixIcon: const SizedBox(
                  width: 100,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VerticalDivider(
                          color: Colors.black,
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          // child: SvgPicture.asset(
                          //     'assests/icons/circle-right-svgrepo-com.svg')),
                          child: Icon(Icons.camera_alt_outlined),
                        )
                      ],
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                )),
          ),
        )
      ],
    );
  }
}
