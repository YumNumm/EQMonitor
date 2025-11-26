# dart_azarashi

A Dart implementation of QZQSM DCR Decoder - Decodes disaster and crisis management reports from QZSS (Quasi-Zenith Satellite System) satellites.

Based on [azarashi](https://github.com/nbtk/azarashi) Python library.

## Features

- Decode DCR (DC Report) messages from JMA (Japan Meteorological Agency)
- Support for multiple input formats: NMEA, Hexadecimal, u-blox binary
- Decode various disaster types:
  - Earthquake Early Warning (緊急地震速報)
  - Hypocenter (震源)
  - Seismic Intensity (震度)
  - Tsunami (津波)
  - Northwest Pacific Tsunami (北西太平洋津波)
  - Nankai Trough Earthquake (南海トラフ地震)
  - Volcano (火山)
  - Ash Fall (降灰)
  - Weather (気象)
  - Flood (洪水)
  - Typhoon (台風)
  - Marine (海上)
- DCX (DC Extended) message support: L-Alert, J-Alert

## Usage

```dart
import 'package:dart_azarashi/dart_azarashi.dart';

final azarashi = DartAzarashi();

// NMEA format ($QZQSM,55,...)
final report = azarashi.nmeaDecoder.decode(
  r'$QZQSM,55,C6AF89A820000324000050400548C5E2C000000003DFF8001C00001185443FC*05',
);

// Hexadecimal format (63 characters)
final report = azarashi.hexDecoder.decode(
  'C6AF89A820000324000050400548C5E2C000000003DFF8001C00001185443FC',
);

// u-blox binary format (SFRBX)
final report = azarashi.ubloxDecoder.decode(
  Uint8List.fromList([0xB5, 0x62, ...]),
);
```

## Reference

- [IS-QZSS-DCR-015](https://qzss.go.jp/en/technical/ps-is-qzss/is-qzss.html) - Interface Specification for DC Report Service
