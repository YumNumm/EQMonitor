import 'package:test/test.dart';

import '../bin/legacy_generated_contract.dart';

void main() {
  test('Parameters互換ファイルだけを保持対象にする', () {
    expect(
      isLegacyGeneratedContractPath(
        relativePath: 'clients/parameters_api_client.dart',
      ),
      isTrue,
    );
    expect(
      isLegacyGeneratedContractPath(
        relativePath: 'models/earthquake_station.freezed.dart',
      ),
      isTrue,
    );
    expect(
      isLegacyGeneratedContractPath(
        relativePath: 'models/hypocenter_response_item.dart',
      ),
      isFalse,
    );
  });

  test('生成ソースへ同じ宣言を重複挿入しない', () {
    const anchor = "export 'clients/hypocenters_api_client.dart';";
    const addition = "export 'clients/parameters_api_client.dart';";

    final once = insertAfterOnce(
      source: anchor,
      anchor: anchor,
      addition: addition,
    );
    final twice = insertAfterOnce(
      source: once,
      anchor: anchor,
      addition: addition,
    );

    expect(twice, '$anchor\n$addition');
  });
}
