import 'package:blockballot/features/user_auth_page/user_auth_page.dart';
import 'package:blockballot/services/metamask/metamask_connector_impl.dart';
import 'package:blockballot/utils/helper/sol_connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants/app_constants.dart';
import '../../widgets/nsalert_dialog.dart';
import '../../widgets/other_custom_widgets.dart';
import '../../widgets/show_snack_bar.dart';
import '../meta_mask_bloc/meta_mask_event.dart';
import '../meta_mask_bloc/meta_mask_state.dart';
import '../meta_mask_bloc/meta_mask_bloc.dart';

class MetaMaskConnectPage extends StatefulWidget {
  static const routename = "metamaskConnect";
  const MetaMaskConnectPage({super.key});

  @override
  State<MetaMaskConnectPage> createState() => _MetaMaskConnectPageState();
}

class _MetaMaskConnectPageState extends State<MetaMaskConnectPage> {
  BuildContext? dialogContext;
  final String signatureFromBackend = "autheticate for blockballot";

  @override
  void initState() {
    // SolConnect().query("retrieve", []).then((value) => print(value));
    super.initState();
  }

  bool showPrivateKey = false;
  var privateKeyTextEditingController = TextEditingController(
    text: "dbfe63866dc9374e17ea608196dfaa471b28f741df8a4c0cd3405a1f36fd0bd1",
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<MetaMaskBloc, WalletState>(
      listener: (context, state) {
        if (state is WalletErrorState) {
          hideDialog(dialogContext);
          ShowSnackBar.buildSnackbar(context, state.message, true);
        } else if (state is WalletReceivedSignatureState) {
          //received signature from metamask success
          hideDialog(dialogContext);
          // ShowSnackBar.buildSnackbar(
          //     context, AppConstants.authenticationSuccessful);
          setState(() {
            showPrivateKey = true;
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<MetaMaskBloc>(context).add(
                  MetamaskAuthEvent(signatureFromBackend: signatureFromBackend),
                );
                buildShowDialog(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset("assets/icon.jpg"),
                  ),
                  const SizedBox(
                    height: 130,
                  ),
                  !showPrivateKey
                      ? Card(
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/metamask_logo.png",
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  AppConstants.metamaskLogin,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              textofield(
                                hint: "enter private key",
                                controller: privateKeyTextEditingController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  MetamaskConnectorImpl().privatekey =
                                      privateKeyTextEditingController.text;
                                  Navigator.of(context)
                                      .popAndPushNamed(UserAuthPage.routename);
                                },
                                child: const Text("next"),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true, //if user should not
        //cancel this dialog then set as false
        builder: (BuildContext dialogContextL) {
          dialogContext = dialogContextL;
          return BlocBuilder<MetaMaskBloc, WalletState>(
              builder: (context, state) {
            return NSAlertDialog(
              textWidget: getText(state),
            );
          });
        });
  }

  getText(WalletState state) {
    String message = "";
    if (state is MetaMaskInitializedState) {
      //initialized metamask success
      message = state.message;
    } else if (state is WalletAuthorizedState) {
      //received authorized approval success
      message = state.message;
    } else if (state is WalletReceivedSignatureState) {
      //received signature from metamask success
      message = state.message;
    }
    return Text(
      message,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }

  Column textofield({
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Private key",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
