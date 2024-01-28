import 'package:blockballot/utils/helper/sol_connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/namespace_utils.dart';

import '../../services/services.dart';
import '../../utils/constants/app_constants.dart';
import 'meta_mask_event.dart';
import 'meta_mask_state.dart';

class MetaMaskBloc extends Bloc<WalletEvent, WalletState> {
  MetaMaskBloc() : super(MetaMaskInitialState()) {
    //now send that signature to the metamask, but before this initialize metamask and approve sign-in request
    on<MetamaskAuthEvent>((event, emit) async {
      emit(MetaMaskInitializedState(message: AppConstants.initializing));
      bool isInitialize = await walletConnectorService.initialize();
      if (isInitialize) {
        emit(MetaMaskInitializedState(message: AppConstants.initialized));
        ConnectResponse? resp = await walletConnectorService
            .connect(); //first connect with metamask

        if (resp != null) {
          //get metamask uri from resp
          Uri? uri = resp.uri;
          if (uri != null) {
            //send metamask request for authorization, before this launch url for redirecting to metamask app
            bool canLaunch = await walletConnectorService.onDisplayUri(uri);
            if (!canLaunch) {
              emit(
                  WalletErrorState(message: AppConstants.metamaskNotInstalled));
            } else {
              SessionData?
                  sessionData = //send  signature to metamask to get authorize
                  await walletConnectorService.authorize(
                      resp, event.signatureFromBackend);
              if (sessionData != null) {
                emit(WalletAuthorizedState(
                    message: AppConstants.connectionSuccessful));
                if (resp.session.isCompleted) {
                  final String walletAddress = NamespaceUtils.getAccount(
                    sessionData.namespaces.values.first.accounts.first,
                  );
                  debugPrint("WALLET ADDRESS - $walletAddress");
                  //now again go to app ans check for message sign in request
                  bool canLaunch =
                      await walletConnectorService.onDisplayUri(uri);
                  if (!canLaunch) {
                    emit(WalletErrorState(
                        message: AppConstants.metamaskNotInstalled));
                  } else {
                    // now send signature to metamask to get signed
                    final signatureFromWallet =
                        await walletConnectorService.sendMessageForSigned(
                            resp,
                            walletAddress,
                            sessionData.topic,
                            event.signatureFromBackend);
                    print(
                        "signtaure is :  ******************************\n $signatureFromWallet");
                    // SolConnect().submit("store", ["67"], signatureFromWallet!);
                    print("________________________________ sent");
                    SolConnect()
                        .query("GetResults", []).then((value) => print(value));
                    if (signatureFromWallet != null &&
                        signatureFromWallet != "") {
                      emit(WalletReceivedSignatureState(
                          signatureFromWallet: signatureFromWallet,
                          signatureFromBk: event.signatureFromBackend,
                          walletAddress: walletAddress,
                          message: AppConstants.authenticatingPleaseWait));
                    } else {
                      //user denied signature request
                      emit(WalletErrorState(
                          message: AppConstants.userDeniedMessageSignature));
                    }
                    //now disconnect wallet
                    // walletConnectorService.disconnectWallet(
                    //     topic: sessionData.topic);

                    // walletConnectorService.query(sessionData)
                  }
                }
              } else {
                //user cancel the connection request with metamask
                emit(WalletErrorState(
                    message: AppConstants.userDeniedConnectionRequest));
              }
            }
          }
        }
      } else {
        emit(WalletErrorState(message: AppConstants.walletConnectError));
      }
    });
  }
}
