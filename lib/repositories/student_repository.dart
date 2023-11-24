import 'package:connection/models/profile.dart';
import 'package:connection/models/student.dart';
import 'package:connection/services/api_service.dart';

class StudentRepository{
  final ApiService api = ApiService();

  Future<bool> dangkyLop() async {
    bool kq = false;
    var response = await api.dangkyLop();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<Student> getStudnetInfo() async{
    Student student = Student();
    var response = await api.getStudentInfo();
    if(response != null){
      var data = response.data;
      student = Student.fromJson(data);
      // Profile().student = Student.fromStudent(student);
    }


    return student;
  }
}