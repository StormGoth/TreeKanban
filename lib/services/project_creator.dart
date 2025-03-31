import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectCreator {
  static Future<Map<String, dynamic>?> showCreateDialog(
    BuildContext context,
  ) async {
    final TextEditingController projectNameController = TextEditingController();
    int selectedColumnCount = 3;

    return await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: projectNameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Project Name',
                  hintText: 'Enter project name',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: selectedColumnCount,
                decoration: const InputDecoration(
                  labelText: 'Number of Columns',
                ),
                items: [3, 4]
                    .map((value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value columns'),
                      );
                    })
                    .toList(),
                onChanged: (value) => selectedColumnCount = value!,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (projectNameController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    'title': projectNameController.text,
                    'columns':
                        selectedColumnCount == 3
                            ? [
                              KanbanColumn(name: 'Task', stateId: 0),
                              KanbanColumn(name: 'In Progress', stateId: 1),
                              KanbanColumn(name: 'Done', stateId: 2),
                            ]
                            : [
                              KanbanColumn(name: 'Task', stateId: 0),
                              KanbanColumn(name: 'In Progress', stateId: 1),
                              KanbanColumn(name: 'Review', stateId: 2),
                              KanbanColumn(name: 'Done', stateId: 3),
                            ],
                  });
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
