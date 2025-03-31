import 'package:flutter/material.dart';

import '../models/project.dart';
import '../services/project_creator.dart';

class ProjectSelectionScreen extends StatefulWidget {
  const ProjectSelectionScreen({super.key});

  @override
  State<ProjectSelectionScreen> createState() => _ProjectSelectionScreenState();
}

class _ProjectSelectionScreenState extends State<ProjectSelectionScreen> {
  final List<Project> _projects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Project')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewProject(context),
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileProjectList();
          } else {
            return _buildDesktopProjectGrid();
          }
        },
      ),
    );
  }

  Future<void> _createNewProject(BuildContext context) async {
    final result = await ProjectCreator.showCreateDialog(context);
    if (result != null) {
      final project = Project(
        title: result['title'],
        columns:
            result['columns']
                .map<KanbanColumn>(
                  (c) => KanbanColumn(name: c.name, stateId: c.stateId),
                )
                .toList(),
      );
      setState(() => _projects.add(project));
      Navigator.pushNamed(context, '/project', arguments: project);
    }
  }

  Widget _buildMobileProjectList() {
    return ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key('project_$index'),
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            final deletedProject = _projects[index];
            setState(() => _projects.removeAt(index));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Project "${deletedProject.title}" deleted'),
              ),
            );
          },
          child: ListTile(
            title: Text(_projects[index].title),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/project',
                arguments: _projects[index],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDesktopProjectGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return Card(
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/project',
                    arguments: _projects[index],
                  );
                },
                child: Center(
                  child: Text(
                    _projects[index].title,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    final deletedProject = _projects[index];
                    setState(() => _projects.removeAt(index));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Project "${deletedProject.title}" deleted',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
