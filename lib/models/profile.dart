import 'package:connection/models/student.dart';
import 'package:connection/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  static final Profile _instance = Profile._internal();

  Profile._internal({this.token = ""});

  factory Profile() {
    return _instance;
  }

  late SharedPreferences _pref;


  late String token;

  Student student = Student();
  User user = User();

  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
    token = "";
  }

  Future<void> setUsernamePassword(String username, String password) async {
    _pref.setString("username", username);
    _pref.setString("password", password);
  }

  String get username => _pref.getString('username') ?? '';

  String get password => _pref.getString('password') ?? '';
}

// class SharedPrefSingleton{
//   static final SharedPrefSingleton _instance = SharedPrefSingleton._internal();
//   factory SharedPrefSingleton() => _instance;
//   SharedPrefSingleton._internal();
//   late SharedPreferences _pref;
//   Future<void> initialize() async{
//     _pref = await SharedPreferences.getInstance();
//
//   }
//
//   Future<bool> setName(String name) => _pref.setString('name key', name);
//   String get name => _pref.getString('name_key') ?? '';
// }
