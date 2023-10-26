class ApiUrl {
  static const String baseUrl = 'https://responsi1b.dalhaqq.xyz/api';

  static const String listAssigment = '$baseUrl/assignments';
  static const String createAssignment = '$baseUrl/assignments';

  static String updateAssignment(int id) {
    return '$baseUrl/assignments/$id/update';
  }

  static String showAssignment(int id) {
    return '$baseUrl/assignments/$id';
  }

  static String deleteAssignment(int id) {
    return '$baseUrl/assignments/$id/delete';
  }
}
