import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter_analysis_request.freezed.dart';

@freezed
abstract class HypocenterAnalysisRequest with _$HypocenterAnalysisRequest {
  const factory HypocenterAnalysisRequest({
    required List<HypocenterArchive> archives,
    required SeismicityBounds bounds,
  }) = _HypocenterAnalysisRequest;
}
