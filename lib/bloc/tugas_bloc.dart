import 'dart:convert';
import 'package:responsi/helpers/api.dart';
import 'package:responsi/helpers/api_url.dart';
import 'package:responsi/model/tugas.dart';

class TugasBloc {
  static Future<List<Tugas>> getTugas() async {
    String apiUrl = ApiUrl.listAssigment;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listTugas = (jsonObj['result']['data'] as List<dynamic>);
    List<Tugas> tugas = [];
    for (int i = 0; i < listTugas.length; i++) {
      tugas.add(Tugas.fromJson(listTugas[i]));
    }
    return tugas;
  }

  static Future addTugas({Tugas? tugas}) async {
    String apiUrl = ApiUrl.createAssignment;

    var body = {
      "title": tugas!.title,
      "description": tugas.description,
      "deadline": tugas.deadline.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateTugas({required Tugas tugas}) async {
    String apiUrl = ApiUrl.updateAssignment(tugas.id!);

    var body = {
      "title": tugas.title,
      "description": tugas.description,
      "deadline": tugas.deadline
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);

    // Periksa status respons dan kembalikan hasil yang sesuai
    if (jsonObj['status'] == 'success') {
      return true; // Berhasil mengubah tugas
    } else {
      return false; // Gagal mengubah tugas
    }
  }

  static Future<bool> deleteTugas({int? id}) async {
    String apiUrl = ApiUrl.deleteAssignment(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }
}
