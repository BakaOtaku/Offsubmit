import 'package:http/http.dart' as http;

class StudentWallet {
  static String privateKey;
  static String credentialAddress;

  StudentWallet(String key, String address) {
    privateKey = key;
    credentialAddress = address;
  }

  String get getPrivateKey => privateKey;
  String get getCredAddress => credentialAddress;

  static Future<StudentWallet> newStudent() async {
    http.Response value =
        await http.get('https://tokensprtify.herokuapp.com/newStudentWallet');
    print("Student Wallet: ${value.body}");
    privateKey = value.body.split(" ")[0];
    credentialAddress = value.body.split(" ")[1];
    return StudentWallet(privateKey, credentialAddress);
  }
}
