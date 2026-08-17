import 'package:eqmonitor/core/router/router.dart';
import 'package:material_ui/material_ui.dart';

class FnetPage extends StatelessWidget {
  const FnetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('F-net 広帯域地震観測網'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('地震カタログ'),
            subtitle: const Text('F-netで観測された地震の履歴を閲覧できます'),
            leading: const Icon(Icons.list_alt),
            onTap: () => const FnetCatalogRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}
