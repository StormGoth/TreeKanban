import 'package:flutter/material.dart';

import 'models/project.dart';
import 'screens/login_screen.dart';
import 'screens/project_detail.dart';
import 'screens/project_selection_screen.dart';

void main() {
  runApp(const TreeKanban());
}

class TreeKanban extends StatelessWidget {
  const TreeKanban({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Kanban',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) => const ProjectSelectionScreen(),
        '/project': (context) {
          final project = ModalRoute.of(context)!.settings.arguments as Project;
          return ProjectDetail(
            columns: project.columns,
            onColumnsChanged: (newColumns) {
              project.updateColumns(newColumns);
            },
          );
        },
      },
    );
  }
}
