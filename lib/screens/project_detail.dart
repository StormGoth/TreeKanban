import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectDetail extends StatefulWidget {
  const ProjectDetail({
    super.key,
    required this.columns,
    this.onColumnsChanged,
  });

  final List<KanbanColumn> columns;
  final Function(List<KanbanColumn>)? onColumnsChanged;

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  late List<KanbanColumn> columns;

  @override
  void initState() {
    super.initState();
    columns = List.from(widget.columns);
  }

  @override
  void didUpdateWidget(ProjectDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.columns != widget.columns) {
      setState(() => columns = List.from(widget.columns));
    }
  }

  Widget _buildMobileLayout() {
    return ListView(
      children: List.generate(columns.length, (index) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey[300],
              child: Center(
                child: TextFormField(
                  initialValue: columns[index].name,
                  onChanged: (value) {
                    List<KanbanColumn> newColumns = List.from(columns);
                    newColumns[index] = KanbanColumn(
                      name: value,
                      stateId: newColumns[index].stateId,
                    );
                    widget.onColumnsChanged?.call(newColumns);
                    setState(() => columns = newColumns);
                  },
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              color: Colors.grey,
              child: Center(child: Text('Column ${index + 1}')),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: List.generate(columns.length, (index) {
        return Expanded(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.grey[300],
                child: Center(
                  child: TextFormField(
                    initialValue: columns[index].name,
                    onChanged: (value) {
                      List<KanbanColumn> newColumns = List.from(columns);
                      newColumns[index] = KanbanColumn(
                        name: value,
                        stateId: newColumns[index].stateId,
                      );
                      setState(() => columns = newColumns);
                      widget.onColumnsChanged?.call(newColumns);
                    },
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Center(child: Text('Column ${index + 1}')),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Details')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout();
          } else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }
}
