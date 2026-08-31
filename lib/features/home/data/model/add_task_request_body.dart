class AddTaskRequestBody {
  final String title;
  final String description;
  final String deliveryDate;

  AddTaskRequestBody({
    required this.title,
    required this.description,
    required this.deliveryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'delivery_date': deliveryDate,
    };
  }
}
