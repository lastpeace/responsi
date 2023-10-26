class ApiUrl {
  static const String baseUrl =
      'https://responsi1b.dalhaqq.xyz/api/assignments';
  static const String listTugas = '$baseUrl/tugas';
  static const String createTugas = '$baseUrl/tugas';
  static String updateTugas(int id) {
    return '$baseUrl/tugas/$id';
  }

  static String showTugas(int id) {
    return '$baseUrl/tugas/$id';
  }

  static String deleteTugas(int id) {
    return '$baseUrl/tugas/$id';
  }
}
