/// External HTTP endpoints. The admin talks to Firebase through its SDKs; the
/// only plain HTTP call is the ImgBB upload (same endpoint as the seed tool).
class ApiEndpoints {
  ApiEndpoints._();

  static Uri imgbbUpload(String apiKey) =>
      Uri.parse('https://api.imgbb.com/1/upload').replace(queryParameters: {'key': apiKey});
}
