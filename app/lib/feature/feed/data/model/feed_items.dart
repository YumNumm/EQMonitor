import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_items.freezed.dart';

enum FeedPriority { critical, high, normal, low }

enum FeedType {
  earthquakeNotice,
  earthquakeExplanation,
  earthquakeCounts,
  earthquakeNankai,
  appUpdate,
  incident,
  developerMessage,
}

enum FeedInfoType { publication, correction, delay, cancellation }

enum FeedTelegramType {
  oneHourEarthquakeCount,
  accumulativeEarthquakeCount,
  earthquakeCount,
}

@freezed
abstract class FeedListResponse with _$FeedListResponse {
  const factory FeedListResponse({
    required List<FeedItem> feeds,
    required String? nextCursor,
  }) = _FeedListResponse;
}

@freezed
abstract class FeedItem with _$FeedItem {
  const factory FeedItem({
    required String id,
    required FeedType feedType,
    required FeedPriority priority,
    required bool isImportant,
    required DateTime publishedAt,
    required DateTime? expiresAt,
    required String? title,
    required String? summary,
    required FeedItemData data,
  }) = _FeedItem;
}

@freezed
abstract class FeedDetail with _$FeedDetail {
  const factory FeedDetail({
    required String id,
    required FeedType feedType,
    required FeedPriority priority,
    required bool isImportant,
    required DateTime publishedAt,
    required DateTime? expiresAt,
    required String? title,
    required String? summary,
    required String? body,
    required FeedItemData data,
  }) = _FeedDetail;
}

@freezed
sealed class FeedItemData with _$FeedItemData {
  const factory FeedItemData.earthquakeNotice({required String text}) =
      FeedItemDataEarthquakeNotice;

  const factory FeedItemData.earthquakeExplanation({
    required FeedInfoType infoType,
    required String text,
    FeedNaming? naming,
    FeedComments? comments,
  }) = FeedItemDataEarthquakeExplanation;

  const factory FeedItemData.earthquakeCounts({
    required FeedInfoType infoType,
    List<FeedEarthquakeCount>? earthquakeCounts,
    String? nextAdvisory,
    String? text,
    FeedComments? comments,
  }) = FeedItemDataEarthquakeCounts;

  const factory FeedItemData.earthquakeNankai({
    required FeedInfoType infoType,
    FeedNankaiEarthquakeInfo? earthquakeInfo,
    String? nextAdvisory,
    String? text,
  }) = FeedItemDataEarthquakeNankai;

  const factory FeedItemData.appUpdate({String? version, String? url}) =
      FeedItemDataAppUpdate;

  const factory FeedItemData.incident({String? url}) = FeedItemDataIncident;

  const factory FeedItemData.developerMessage({String? url}) =
      FeedItemDataDeveloperMessage;
}

@freezed
abstract class FeedComments with _$FeedComments {
  const factory FeedComments({required String free}) = _FeedComments;
}

@freezed
abstract class FeedNaming with _$FeedNaming {
  const factory FeedNaming({required String text, String? en}) = _FeedNaming;
}

@freezed
abstract class FeedEarthquakeCount with _$FeedEarthquakeCount {
  const factory FeedEarthquakeCount({
    required FeedTelegramType type,
    required FeedEarthquakeCountTargetTime targetTime,
    required FeedEarthquakeCountValues values,
  }) = _FeedEarthquakeCount;
}

@freezed
abstract class FeedEarthquakeCountTargetTime
    with _$FeedEarthquakeCountTargetTime {
  const factory FeedEarthquakeCountTargetTime({
    required String start,
    required String end,
  }) = _FeedEarthquakeCountTargetTime;
}

@freezed
abstract class FeedEarthquakeCountValues with _$FeedEarthquakeCountValues {
  const factory FeedEarthquakeCountValues({
    required String? all,
    required String? felt,
  }) = _FeedEarthquakeCountValues;
}

@freezed
abstract class FeedNankaiEarthquakeInfo with _$FeedNankaiEarthquakeInfo {
  const factory FeedNankaiEarthquakeInfo({
    required String text,
    FeedNankaiEarthquakeInfoKind? kind,
    String? appendix,
  }) = _FeedNankaiEarthquakeInfo;
}

@freezed
abstract class FeedNankaiEarthquakeInfoKind
    with _$FeedNankaiEarthquakeInfoKind {
  const factory FeedNankaiEarthquakeInfoKind({
    required String code,
    required String name,
  }) = _FeedNankaiEarthquakeInfoKind;
}

extension FeedListResponseApiExtension on api.FeedListResponse {
  FeedListResponse toFeedListResponse() => FeedListResponse(
    feeds: feeds.map((e) => e.toFeedItem()).toList(),
    nextCursor: nextCursor,
  );
}

extension FeedItemApiExtension on api.FeedItem {
  FeedItem toFeedItem() => FeedItem(
    id: id,
    feedType: feedType.toFeedType(),
    priority: priority.toFeedPriority(),
    isImportant: isImportant,
    publishedAt: DateTime.parse(publishedAt),
    expiresAt: switch (expiresAt) {
      final value? => DateTime.tryParse(value),
      null => null,
    },
    title: title,
    summary: summary,
    data: data.toFeedItemData(),
  );
}

extension FeedDetailResponseApiExtension on api.FeedDetailResponse {
  FeedDetail toFeedDetail() => FeedDetail(
    id: id,
    feedType: feedType.toFeedType(),
    priority: priority.toFeedPriority(),
    isImportant: isImportant,
    publishedAt: DateTime.parse(publishedAt),
    expiresAt: switch (expiresAt) {
      final value? => DateTime.tryParse(value),
      null => null,
    },
    title: title,
    summary: summary,
    body: body,
    data: data.toFeedItemData(),
  );
}

extension FeedTypeApiExtension on api.FeedType {
  FeedType toFeedType() => switch (this) {
    api.FeedType.earthquakeNotice => FeedType.earthquakeNotice,
    api.FeedType.earthquakeExplanation => FeedType.earthquakeExplanation,
    api.FeedType.earthquakeCounts => FeedType.earthquakeCounts,
    api.FeedType.earthquakeNankai => FeedType.earthquakeNankai,
    api.FeedType.appUpdate => FeedType.appUpdate,
    api.FeedType.incident => FeedType.incident,
    api.FeedType.developerMessage => FeedType.developerMessage,
  };
}

extension FeedPriorityApiExtension on api.FeedPriority {
  FeedPriority toFeedPriority() => switch (this) {
    api.FeedPriority.critical => FeedPriority.critical,
    api.FeedPriority.high => FeedPriority.high,
    api.FeedPriority.normal => FeedPriority.normal,
    api.FeedPriority.low => FeedPriority.low,
  };
}

extension FeedInfoTypeApiExtension on api.InfoType {
  FeedInfoType toFeedInfoType() => switch (this) {
    api.InfoType.publication => FeedInfoType.publication,
    api.InfoType.correction => FeedInfoType.correction,
    api.InfoType.delay => FeedInfoType.delay,
    api.InfoType.cancellation => FeedInfoType.cancellation,
  };
}

extension FeedTelegramTypeApiExtension on api.FeedTelegramType {
  FeedTelegramType toFeedTelegramType() => switch (this) {
    api.FeedTelegramType.oneHourEarthquakeCount =>
      FeedTelegramType.oneHourEarthquakeCount,
    api.FeedTelegramType.accumulativeEarthquakeCount =>
      FeedTelegramType.accumulativeEarthquakeCount,
    api.FeedTelegramType.earthquakeCount => FeedTelegramType.earthquakeCount,
  };
}

extension FeedItemDataUnionApiExtension on api.FeedItemDataUnion {
  FeedItemData toFeedItemData() => switch (this) {
    api.FeedItemDataUnionFeedEarthquakeNoticeData(:final text) =>
      FeedItemData.earthquakeNotice(text: text),
    api.FeedItemDataUnionFeedEarthquakeExplanationData(
      :final infoType,
      :final text,
      :final naming,
      :final comments,
    ) =>
      FeedItemData.earthquakeExplanation(
        infoType: infoType.toFeedInfoType(),
        text: text,
        naming: naming?.toFeedNaming(),
        comments: comments?.toFeedComments(),
      ),
    api.FeedItemDataUnionFeedEarthquakeCountsData(
      :final infoType,
      :final earthquakeCounts,
      :final nextAdvisory,
      :final text,
      :final comments,
    ) =>
      FeedItemData.earthquakeCounts(
        infoType: infoType.toFeedInfoType(),
        earthquakeCounts: earthquakeCounts
            ?.map((e) => e.toFeedEarthquakeCount())
            .toList(),
        nextAdvisory: nextAdvisory,
        text: text,
        comments: comments?.toFeedComments(),
      ),
    api.FeedItemDataUnionFeedEarthquakeNankaiData(
      :final infoType,
      :final earthquakeInfo,
      :final nextAdvisory,
      :final text,
    ) =>
      FeedItemData.earthquakeNankai(
        infoType: infoType.toFeedInfoType(),
        earthquakeInfo: earthquakeInfo?.toFeedNankaiEarthquakeInfo(),
        nextAdvisory: nextAdvisory,
        text: text,
      ),
    api.FeedItemDataUnionFeedAppUpdateData(:final version, :final url) =>
      FeedItemData.appUpdate(version: version, url: url),
    api.FeedItemDataUnionFeedIncidentData(:final url) => FeedItemData.incident(
      url: url,
    ),
    api.FeedItemDataUnionFeedDeveloperMessageData(:final url) =>
      FeedItemData.developerMessage(url: url),
  };
}

extension FeedCommentsApiExtension on api.FeedComments {
  FeedComments toFeedComments() => FeedComments(free: free);
}

extension FeedNamingApiExtension on api.FeedNaming {
  FeedNaming toFeedNaming() => FeedNaming(text: text, en: en);
}

extension FeedEarthquakeCountApiExtension on api.FeedEarthquakeCount {
  FeedEarthquakeCount toFeedEarthquakeCount() => FeedEarthquakeCount(
    type: type.toFeedTelegramType(),
    targetTime: targetTime.toFeedEarthquakeCountTargetTime(),
    values: values.toFeedEarthquakeCountValues(),
  );
}

extension FeedEarthquakeCountTargetTimeApiExtension
    on api.FeedEarthquakeCountTargetTime {
  FeedEarthquakeCountTargetTime toFeedEarthquakeCountTargetTime() =>
      FeedEarthquakeCountTargetTime(start: start, end: end);
}

extension FeedEarthquakeCountValuesApiExtension
    on api.FeedEarthquakeCountValues {
  FeedEarthquakeCountValues toFeedEarthquakeCountValues() =>
      FeedEarthquakeCountValues(all: all, felt: felt);
}

extension FeedNankaiEarthquakeInfoApiExtension on api.FeedNankaiEarthquakeInfo {
  FeedNankaiEarthquakeInfo toFeedNankaiEarthquakeInfo() =>
      FeedNankaiEarthquakeInfo(
        text: text,
        kind: kind?.toFeedNankaiEarthquakeInfoKind(),
        appendix: appendix,
      );
}

extension FeedNankaiEarthquakeInfoKindApiExtension
    on api.FeedNankaiEarthquakeInfoKind {
  FeedNankaiEarthquakeInfoKind toFeedNankaiEarthquakeInfoKind() =>
      FeedNankaiEarthquakeInfoKind(code: code, name: name);
}
