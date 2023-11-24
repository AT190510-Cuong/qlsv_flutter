import 'package:connection/models/place.dart';
import 'package:connection/services/api_service.dart';

class PlaceRepository {
  Future<List<City>> getListCity() async {
    List<City> list = [];
    list.add(City(id: 0, name: '--chọn--'));
    var datas = await ApiService().getListCity();
    if (datas != null) {
      for (var item in datas) {
        var city = City.fromJson(item);
        list.add(city);
      }
    }

    return list;
  }

  Future<List<District>> getListDistrict(int id) async {
    List<District> list = [];
    list.add(District(id: 0, name: '--chọn--', level: 0));

    var datas = await ApiService().getListDistrict(id);
    if (datas != null) {
      for (var item in datas) {
        var district = District.fromJson(item);
        list.add(district);
      }
    }

    return list;
  }

  Future<List<Ward>> getListWard(int id) async {
    List<Ward> list = [];
    list.add(Ward(id: 0, name: '--chọn--'));

    var datas = await ApiService().getListWard(id);
    if (datas != null) {
      for (var item in datas) {
        var ward = Ward.fromJson(item);
        list.add(ward);
      }
    }

    return list;
  }
}
