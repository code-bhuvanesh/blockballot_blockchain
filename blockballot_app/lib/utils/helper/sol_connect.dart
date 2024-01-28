import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import '../constants/constants.dart';

class SolConnect {
  late http.Client _httpClient;
  late Web3Client _ethClient;
  late DeployedContract _contract;

  bool _contractLoaded = false;

  SolConnect() {
    _httpClient = http.Client();
    _ethClient = Web3Client(Constants.rpcurl, _httpClient);
  }

  Future<void> loadContract() async {
    if (!_contractLoaded) {
      String abi = await rootBundle.loadString("assets/abi.json");
      String contractAddress = Constants.contractAddress;
      final contract = DeployedContract(
        ContractAbi.fromJson(abi, Constants.solName),
        EthereumAddress.fromHex(contractAddress),
      );
      _contract = contract;
      _contractLoaded = true;
    }
  }

  Future<List<dynamic>> query(String funtionName, List<dynamic> args) async {
    await loadContract();
    final ethFuntion = _contract.function(funtionName);
    final result = await _ethClient.call(
      contract: _contract,
      function: ethFuntion,
      params: args,
    );
    return result;
  }

  Future<String> submit(
      String funtionName, List<dynamic> args, String credentialStr,
      {String? eventName}) async {
    await loadContract();
    EthPrivateKey credential = EthPrivateKey.fromHex(
      Constants.privatekey,
    );
    // EthPrivateKey credential = EthPrivateKey.fromHex(
    //   credentialStr,
    // );

    final ethFunction = _contract.function(funtionName);
    final result = await _ethClient.sendTransaction(
      credential,
      Transaction.callContract(
        contract: _contract,
        function: ethFunction,
        parameters: args,
        from: EthereumAddress.fromHex(Constants.publickey),
        // maxGas: 100000,
      ),
      chainId: 11155111,
    );

    // await _checkTrasactionStatus(result);
    if (eventName != null) {
      _ethClient
          .events(FilterOptions.events(
              contract: _contract,
              event: ContractEvent(
                false,
                eventName,
                [],
              )))
          .listen((event) {
        print(event);
      });
    }

    return result;
  }

  Future<void> getBalance() async {
    var address = EthereumAddress.fromHex(Constants.publickey);
    EtherAmount balance = await _ethClient.getBalance(address);
    print("balance");
    print(balance.getValueInUnit(EtherUnit.ether));
  }

  // Future<String> _checkTrasactionStatus(String transactionHash) async {
  //   Map<String, dynamic> jsonResponse = {"status": ""};
  //   Uri url = Uri.parse(
  //     "$etherscanUrl?module=transaction&action=gettxreceiptstatus&txhash=$transactionHash&apikey=$etherscanApiKey",
  //   );
  //   print("transaction id: $transactionHash");
  //   while (jsonResponse["status"] == "") {
  //     print("checking trasacation again......");
  //     var response = await http.get(url);
  //     jsonResponse = jsonDecode(response.body);
  //     jsonResponse = jsonResponse["result"] as Map<String, dynamic>;

  //     print("tranasction result : ${response.body}");
  //     await Future.delayed(const Duration(seconds: 3));
  //   }
  //   return jsonResponse["status"];
  // }
}
