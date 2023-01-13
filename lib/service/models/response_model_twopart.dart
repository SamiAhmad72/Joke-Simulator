class ResponseModel2 {
  late String setup;
  late String delivery;

  ResponseModel2({required this.setup, required this.delivery});
  ResponseModel2.fromJson(Map<String, dynamic> json) {
    setup = json['setup'];
    delivery = json['delivery'];
  }
}
