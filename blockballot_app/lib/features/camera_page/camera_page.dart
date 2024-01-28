import 'dart:io';

import 'package:blockballot/features/voters_page/voters_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  static const routename = "camera_page";
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // String? baseUrl = Env.URL_PREFIX_LIST[2];
  Map<String, dynamic>? currentStudentMap;
  final employeeListKey = GlobalKey<_CameraPageState>();
  late ImagePicker imagePicker;
  File? imageToShow;
  TextStyle infoTextStyle1 =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  TextStyle infoTextStyle2 =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  var loading = false;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    // setState(() {
    //   loading = true;
    // });
    // print(baseUrl);
    // check_server();
  }

  // void check_server() async {
  //   for (var url in Env.URL_PREFIX_LIST) {
  //     if (baseUrl == "" || baseUrl == null) {
  //       print("trying : $url");
  //       var response = await http.post(Uri.parse(url));

  //       if (response.statusCode == 200) {
  //         setState(() {
  //           print("connected");
  //           baseUrl = url;
  //           loading = false;
  //         });
  //         break;
  //       } else {
  //         baseUrl = null;
  //       }
  //     }
  //   }
  //   if (baseUrl == null) {
  //     print("cannot connect");
  //     setState(() {
  //       baseUrl = null;
  //       loading = false;
  //     });
  //   }
  // }

  void takePhoto() async {
    setState(() {
      imageToShow = null;
    });
    var xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile == null) {
      return;
    }
    // sendImage(xFile);
    setState(() {
      File file = File(xFile.path);
      imageToShow = file;
    });
  }

  // void sendImage(XFile xFile) async {
  //   if (baseUrl == "" || baseUrl == null) {
  //     return;
  //   }
  //   setState(() {
  //     loading = true;
  //   });
  //   currentStudent == null;
  //   currentStudentMap == null;
  //   try {
  //     // final uri = Uri.parse("${Env.URL_PREFIX}/upload");
  //     File file = File(xFile.path);
  //     setState(() {
  //       imageToShow = file;
  //     });
  //     String url = '$baseUrl/upload/';
  //     print(url);
  //     var request = http.MultipartRequest('POST', Uri.parse(url));
  //     var fileStream = http.ByteStream(file.openRead());
  //     var fileLength = await file.length();
  //     var multipartFile = http.MultipartFile('file', fileStream, fileLength,
  //         filename: "send image");
  //     request.files.add(multipartFile);
  //     print("loading");
  //     var response = await request.send();
  //     if (response.statusCode == 200) {
  //       // json.decode(response.).cast<Map<String, dynamic>>();
  //       dynamic data = json
  //           .decode(await response.stream.bytesToString())
  //           .cast<Map<String, dynamic>>();
  //       print("file sent");
  //       print(data);

  //       setState(() {
  //         loading = false;

  //         if (data[0]["details"] != null) {
  //           currentStudent = Student.fromJson(
  //             Map<String, dynamic>.from(data[0]["details"]),
  //           );
  //           currentStudentMap = data[0]["details"];

  //           showCustomDialog();
  //         } else {
  //           showDialog(
  //             context: context,
  //             builder: (context) => Dialog(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20.0)),
  //               child: const SizedBox(
  //                 width: 300,
  //                 height: 300,
  //                 child: Center(
  //                   child: Text("cannot detect face. Try Again!"),
  //                 ),
  //               ),
  //             ),
  //           );
  //         }
  //       });
  //     } else {
  //       print("file not send");
  //       print(response.statusCode);
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  //   if (loading) {
  //     setState(() {
  //       loading = false;
  //     });
  //   }
  // }

  Widget customButton(void Function() onpressed, String text) {
    return GestureDetector(
      onTap: onpressed,
      child: Card(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: employeeListKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 229, 255, 1),
        title: const Text(
          'Face Capture',
        ),
        centerTitle: true,
      ),
      body: Container(
        // color: Color.fromARGB(255, 226, 172, 172),
        // color: Color.fromARGB(255, 201, 117, 117),
        child: Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromRGBO(238, 229, 255, 1),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                                color: Color.fromARGB(255, 235, 227, 220),
                                child: (imageToShow == null)
                                    ? Image.asset("assets/empty_image.png")
                                    : Image.file(imageToShow!))),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customButton(
                          imageToShow == null
                              ? takePhoto
                              : () => Navigator.of(context)
                                  .pushNamed(VotersPage.routename),
                          imageToShow == null ? " Take Photo " : " next ",
                        ),
                      ],
                    ),
                  ),
                ),
                // Text(FaceName)
              ],
            ),
          ),
          loading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Color.fromARGB(167, 223, 222, 219),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox.shrink(),
          // (baseUrl == null)
          //     ? Container(
          //         width: double.infinity,
          //         height: double.infinity,
          //         color: Color.fromARGB(167, 223, 222, 219),
          //         child: Column(
          //           children: [
          //             Text("Cannot connect to Server"),
          //             ElevatedButton(
          //               onPressed: check_server,
          //               child: Text("refresh"),
          //             )
          //           ],
          //         ),
          //       )
          //     : const SizedBox.shrink(),
        ]),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () async {
      //       String url = "http://10.240.1.128:8000/register/";
      //       var urllaunchable = await canLaunchUrl(
      //           Uri.parse(url)); //canLaunch is from url_launcher package
      //       if (urllaunchable) {
      //         await launchUrl(Uri.parse(
      //             url)); //launch is from url_launcher package to launch URL
      //       } else {
      //         print("URL can't be launched.");
      //       }
      //     },
      // child: Icon(Icons.add)),
    );
  }
}
