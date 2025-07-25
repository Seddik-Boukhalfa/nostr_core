import 'dart:convert';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart';

/// Encrypted Direct Message
class Nip4 {
  static var secp256k1 = ECDomainParameters("secp256k1");

  static ECDHBasicAgreement getAgreement(String sk) {
    var skD0 = BigInt.parse(sk, radix: 16);
    var privateKey = ECPrivateKey(skD0, secp256k1);

    var agreement = ECDHBasicAgreement();
    agreement.init(privateKey);

    return agreement;
  }

  static String encrypt(String priv, String pub, String text) {
    return encryptWithAgreement(text, getAgreement(priv), pub);
  }

  static String decrypt(String priv, String pub, String text) {
    return decryptWithAgreement(text, getAgreement(priv), pub);
  }

  static String encryptWithAgreement(
      String message, ECDHBasicAgreement agreement, String publicKey) {
    var pubKey = getPubKey(publicKey);
    var agreementD0 = agreement.calculateAgreement(pubKey);
    var encryptKey = agreementD0.toRadixString(16).padLeft(64, "0");

    final random = Random.secure();
    var ivData =
        Uint8List.fromList(List<int>.generate(16, (i) => random.nextInt(256)));
    // var iv = "UeAMaJl5Hj6IZcot7zLfmQ==";
    // var ivData = base64.decode(iv);

    final cipherCbc =
        PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
    final paramsCbc = PaddedBlockCipherParameters(
        ParametersWithIV(
            KeyParameter(Uint8List.fromList(hex.decode(encryptKey))), ivData),
        null);
    cipherCbc.init(true, paramsCbc);

    // print(cipherCbc.algorithmName);

    var result = cipherCbc.process(Uint8List.fromList(utf8.encode(message)));

    return "${base64.encode(result)}?iv=${base64.encode(ivData)}";
  }

  static String decryptWithAgreement(
    String message,
    ECDHBasicAgreement agreement,
    String publicKey,
  ) {
    try {
      var strs = message.split("?iv=");
      if (strs.length != 2) {
        return "";
      }
      message = strs[0];
      var iv = strs[1];
      var ivData = base64.decode(iv);

      var pubKey = getPubKey(publicKey);
      var agreementD0 = agreement.calculateAgreement(pubKey);
      var encryptKey = agreementD0.toRadixString(16).padLeft(64, "0");

      // var encrypter = Encrypter(AES(
      //     Key(Uint8List.fromList(hex.decode(encryptKey))),
      //     mode: AESMode.cbc));
      // return encrypter.decrypt(Encrypted.from64(message), iv: IV.fromBase64(iv));

      final cipherCbc =
          PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));
      final paramsCbc = PaddedBlockCipherParameters(
        ParametersWithIV(
            KeyParameter(
              Uint8List.fromList(
                hex.decode(encryptKey),
              ),
            ),
            ivData),
        null,
      );
      cipherCbc.init(false, paramsCbc);

      var result = cipherCbc.process(base64.decode(message));

      return utf8.decode(result);
    } catch (_) {
      return '';
    }
  }

  static ECPublicKey getPubKey(String pk) {
    // BigInt x = BigInt.parse(pk, radix: 16);
    BigInt x =
        BigInt.parse(hex.encode(hex.decode(pk.padLeft(64, '0'))), radix: 16);
    BigInt? y;
    try {
      y = liftX(x);
    } on Error {
      if (kDebugMode) {
        print("error in handle pubKey");
      }
    }
    ECPoint endPoint = secp256k1.curve.createPoint(x, y!);
    return ECPublicKey(endPoint, secp256k1);
  }

  static var curveP = BigInt.parse(
      'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F',
      radix: 16);

  // helper methods:
  // liftX returns Y for this X
  static BigInt liftX(BigInt x) {
    if (x >= curveP) {
      throw Error();
    }
    var ySq = (x.modPow(BigInt.from(3), curveP) + BigInt.from(7)) % curveP;
    var y = ySq.modPow((curveP + BigInt.one) ~/ BigInt.from(4), curveP);
    if (y.modPow(BigInt.two, curveP) != ySq) {
      throw Error();
    }
    return y % BigInt.two == BigInt.zero /* even */ ? y : curveP - y;
  }

  static List<List<String>> toTags(String p, String e, int? expiration) {
    List<List<String>> result = [];
    result.add(["p", p]);
    if (e.isNotEmpty) result.add(["e", e, '', 'reply']);
    if (expiration != null) result.add(['expiration', expiration.toString()]);
    return result;
  }

  static String generate16RandomHexChars() {
    final random = Random.secure();
    final randomBytes = List<int>.generate(16, (i) => random.nextInt(256));
    return hex.encode(randomBytes);
  }
}
