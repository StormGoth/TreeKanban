class KanbanColumn {
  String name;
  int stateId;

  KanbanColumn({required this.name, required this.stateId});

  Map<String, dynamic> toJson() => {'name': name, 'stateId': stateId};
}

class Project {
  final String title;
  List<KanbanColumn> columns;

  Project({required this.title, required this.columns});

  void updateColumns(List<KanbanColumn> newColumns) {
    columns = newColumns;
  }
}
