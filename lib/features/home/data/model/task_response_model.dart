class TaskResponseModel {
  final List<TaskModel> tasks;
  final MetaModel? meta;
  final String? error;

  TaskResponseModel({required this.tasks, this.meta, this.error});

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskResponseModel(
      tasks: json['data'] != null
          ? (json['data'] as List).map((e) => TaskModel.fromJson(e)).toList()
          : [],
      meta: json['meta'] != null ? MetaModel.fromJson(json['meta']) : null,
      error: json['error'],
    );
  }
}

class TaskModel {
  final int taskId;
  final String title;
  final String description;
  final String status;
  final String deliveryDate;
  final String priority;
  final String createdAt;

  TaskModel({
    required this.taskId,
    required this.title,
    required this.description,
    required this.status,
    required this.deliveryDate,
    required this.priority,
    required this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'] != null ? int.parse(json['taskId'].toString()) : 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      deliveryDate: json['deliveryDate'] ?? '',
      priority: json['priority'] ?? 'low',
      createdAt: json['createdAt'] ?? '',
    );
  }

  bool get isCompleted => status.toLowerCase() == 'completed';
}

class MetaModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int numberOfPages;
  final int total;

  MetaModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.numberOfPages,
    required this.total,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      numberOfPages: json['number_of_pages'] ?? 1,
      total: json['total'] ?? 0,
    );
  }
}
