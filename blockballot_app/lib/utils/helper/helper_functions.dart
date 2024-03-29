Uri? formatNativeUrl(String? deepLink, String wcUri) {
  String safeAppUrl = deepLink ?? "";

  if (deepLink != null && deepLink.isNotEmpty) {
    if (!safeAppUrl.contains('://')) {
      safeAppUrl = deepLink.replaceAll('/', '').replaceAll(':', '');
      safeAppUrl = '$safeAppUrl://';
    }
  }

  String encodedWcUrl = Uri.encodeComponent(wcUri);

  print("this is the native uri : ${Uri.parse('$safeAppUrl$encodedWcUrl')}");

  return Uri.parse('$safeAppUrl$encodedWcUrl');
}
