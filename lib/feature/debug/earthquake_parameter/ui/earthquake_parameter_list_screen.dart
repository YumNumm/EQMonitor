import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'EarthquakeParameterListScreen',
  type: EarthquakeParameterListScreen,
)
Widget earthquakeParameterListScreen(BuildContext _) =>
    const EarthquakeParameterListScreen();

class EarthquakeParameterListScreen extends StatelessWidget {
  const EarthquakeParameterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake Parameter'),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jmaParameterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Etag: ${ref.watch(earthquakeParameterEtagProvider)}',
          ),
        ),
        Expanded(
          child: state.when(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (error, stackTrace) => Center(
              child: Text('Error: $error\n$stackTrace'),
            ),
            data: (data) {
              final regions = data.earthquake.regions;
              return ListView.builder(
                itemCount: regions.length,
                itemBuilder: (context, index) {
                  final region = regions[index];
                  final citiesCount = region.cities.length;
                  final stationsCount = region.cities
                      .map((e) => e.stations.length)
                      .fold(0, (a, b) => a + b);
                  return ListTile(
                    title: Text('${region.code}: ${region.name}'),
                    subtitle:
                        Text('Cities: $citiesCount, Stations: $stationsCount'),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
