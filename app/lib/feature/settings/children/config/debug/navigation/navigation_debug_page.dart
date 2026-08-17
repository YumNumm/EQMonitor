import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class NavigationDebugPage extends StatelessWidget {
  const NavigationDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('ナビゲーション'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _RouteDropdownMenu(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteDropdownMenu extends HookWidget {
  const _RouteDropdownMenu();

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final routeBases = router.configuration.routes;
    final dropdownMenuEntries = useMemoized(
      () {
        final paths = routeBases.toPaths();
        return paths
            .where((path) => !path.contains('debug'))
            .map((path) => DropdownMenuEntry<String>(value: path, label: path))
            .toList();
      },
      routeBases,
    );
    final pathEditController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownMenu<String>(
          dropdownMenuEntries: dropdownMenuEntries,
          expandedInsets: EdgeInsets.zero,
          onSelected: (selectedPath) {
            if (selectedPath == null) {
              return;
            }
            pathEditController.text = selectedPath;
          },
        ),
        const SizedBox.square(dimension: 16),
        TextField(
          controller: pathEditController,
          decoration: const InputDecoration(
            label: Text('Path'),
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        const SizedBox.square(dimension: 16),
        ElevatedButton(
          onPressed: () => router.go(pathEditController.text),
          child: const Text('Go'),
        ),
      ],
    );
  }
}

extension _ToPaths on List<RouteBase> {
  List<String> toPaths([String? parentPath]) {
    final routes = <String>[];
    for (final routeBase in this) {
      switch (routeBase) {
        case GoRoute():
          final path = parentPath != null
              ? '${parentPath.endsWith('/') ? parentPath : '$parentPath/'}${routeBase.path.startsWith('/') ? routeBase.path.substring(1) : routeBase.path}'
              : routeBase.path;
          routes.add(path);
          if (routeBase.routes.isNotEmpty) {
            routes.addAll(routeBase.routes.toPaths(path));
          }
        case ShellRoute() || StatefulShellRoute():
          routes.addAll(routeBase.routes.toPaths(parentPath));
      }
    }
    return routes;
  }
}
