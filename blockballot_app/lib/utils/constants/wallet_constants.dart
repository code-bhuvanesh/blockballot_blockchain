import '../../data/models/chain_metadata.dart';

//etherum main net
// class WalletConstants {
//   static const mainChainMetaData = ChainMetadata(
//     type: "eip155",
//     chainId: 'eip155:1',
//     name: 'Ethereum',
//     method: "personal_sign",
//     events: ["chainChanged", "accountsChanged"],
//     relayUrl: "wss://relay.walletconnect.com",
//     projectId: "2d7bf6b9dea0a6966725c8e83c686f1c",
//     redirectUrl: "metamask://com.example.blockballot",
//     walletConnectUrl: "https://walletconnect.com",
//   );
//   static const deepLinkMetamask = "metamask://wc?uri=";
// }

//sleopia
class WalletConstants {
  static const mainChainMetaData = ChainMetadata(
    type: "eip155",
    chainId: 'eip155:11155111',
    name: 'Sepolia Test Network',
    // method: "personal_sign",
    method: "eth_requestAccounts",
    events: ["chainChanged", "accountsChanged"],
    relayUrl: "wss://relay.walletconnect.com",
    projectId: "2d7bf6b9dea0a6966725c8e83c686f1c",
    redirectUrl: "metamask://com.example.blockballot",
    walletConnectUrl: "https://walletconnect.com",
  );
  static const deepLinkMetamask = "metamask://wc?uri=";
}
