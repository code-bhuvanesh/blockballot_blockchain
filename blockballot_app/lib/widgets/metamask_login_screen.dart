import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/meta_mask_bloc/meta_mask_event.dart';
import '../features/meta_mask_bloc/meta_mask_state.dart';
import '../features/meta_mask_bloc/meta_mask_bloc.dart';
import '../utils/constants/app_constants.dart';
import 'nsalert_dialog.dart';
import 'other_custom_widgets.dart';
import 'show_snack_bar.dart';

class MetaMaskLoginScreen extends StatefulWidget {
  const MetaMaskLoginScreen({super.key});

  @override
  State<MetaMaskLoginScreen> createState() => _MetaMaskLoginScreenState();
}

class _MetaMaskLoginScreenState extends State<MetaMaskLoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  BuildContext? dialogContext;
  final String signatureFromBackend = "NonStop IO Technologies Pvt Ltd.";
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
          ShowSnackBar.buildSnackbar(
              context, AppConstants.authenticationSuccessful);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Center(
            child: InkWell(
              onTap: () {
                BlocProvider.of<MetaMaskBloc>(context).add(
                  MetamaskAuthEvent(signatureFromBackend: signatureFromBackend),
                );
                buildShowDialog(context);
              },
              child: const Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   Assets.metamaskIcon,
                      //   height: 40,
                      //   width: 40,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppConstants.metamaskLogin,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: _scaffoldKey.currentContext ?? context,
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
}
