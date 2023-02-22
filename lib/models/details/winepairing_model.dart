class WinePairing {
  String? pairingText;

  WinePairing({this.pairingText});

  factory WinePairing.fromJson(Map<String,dynamic> json) {
    return WinePairing(
      pairingText: json['pairingText'],
    );
  }
}