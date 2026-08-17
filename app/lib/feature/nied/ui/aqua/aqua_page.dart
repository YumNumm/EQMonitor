import 'package:eqmonitor/core/router/router.dart';
import 'package:material_ui/material_ui.dart';

class AquaPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AQUAシステム'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('メカニズム解カタログ'),
            subtitle: const Text('地震のメカニズム解（CMT・MT解）を閲覧できます'),
            leading: const Icon(Icons.list_alt),
            onTap: () async => const AquaCatalogRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}
