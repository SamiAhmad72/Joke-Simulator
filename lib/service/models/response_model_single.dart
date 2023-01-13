class ResponseModel {
  late String joke;

  ResponseModel({required this.joke});
  ResponseModel.fromJson(Map<String, dynamic> json) {
    joke = json['joke'];
  }
}
