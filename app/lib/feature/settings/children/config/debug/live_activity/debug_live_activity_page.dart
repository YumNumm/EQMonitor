import 'dart:io';

import 'package:eqmonitor/core/provider/live_activity/live_activity_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:live_activities/live_activities.dart';

class DebugLiveActivityPage extends HookConsumerWidget {
  const DebugLiveActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSupported = Platform.isIOS;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Activity Debug'),
      ),
      body: isSupported
          ? const _LiveActivityContent()
          : const Center(
              child: Text('Live ActivityはiOSでのみ利用可能です'),
            ),
    );
  }
}

class _LiveActivityContent extends HookConsumerWidget {
  const _LiveActivityContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveActivities = ref.watch(liveActivitiesProvider);

    return ListView(
      children: [
        const _SectionHeader(title: '初期化'),
        _InitSection(liveActivities: liveActivities),
        const Divider(),
        const _SectionHeader(title: 'ステータス'),
        _StatusTile(liveActivities: liveActivities),
        const Divider(),
        const _SectionHeader(title: 'Push-to-Start Token'),
        _PushToStartTokenSection(liveActivities: liveActivities),
        const Divider(),
        const _SectionHeader(title: 'EEW Live Activity'),
        _EewLiveActivitySection(liveActivities: liveActivities),
        const Divider(),
        const _SectionHeader(title: '揺れ検知 Live Activity'),
        _ShakeDetectionLiveActivitySection(liveActivities: liveActivities),
        const Divider(),
        const _SectionHeader(title: 'アクティブなLive Activity'),
        _ActiveActivitiesSection(liveActivities: liveActivities),
      ],
    );
  }
}

class _InitSection extends StatefulWidget {
  const _InitSection({required this.liveActivities});

  final LiveActivities liveActivities;

  @override
  State<_InitSection> createState() => _InitSectionState();
}

class _InitSectionState extends State<_InitSection> {
  var _isInitialized = false;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            _isInitialized ? Icons.check_circle : Icons.circle_outlined,
            color: _isInitialized ? Colors.green : Colors.grey,
          ),
          title: const Text('Live Activity 初期化'),
          subtitle: Text(_isInitialized ? '初期化済み' : '未初期化'),
          trailing: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : ElevatedButton(
                  onPressed: _init,
                  child: const Text('Init'),
                ),
        ),
      ],
    );
  }

  Future<void> _init() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.liveActivities.init(
        appGroupId: 'group.net.yumnumm.eqmonitor',
        urlScheme: 'eqmonitor',
      );

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Live Activity初期化完了'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('初期化エラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({required this.liveActivities});

  final LiveActivities liveActivities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Live Activity サポート'),
          trailing: FutureBuilder<bool>(
            future: liveActivities.areActivitiesSupported(),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? false ? '対応' : '非対応',
                style: TextStyle(
                  color: snapshot.data ?? false ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ),
        ListTile(
          title: const Text('Live Activity 有効'),
          trailing: FutureBuilder<bool>(
            future: liveActivities.areActivitiesEnabled(),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? false ? '有効' : '無効',
                style: TextStyle(
                  color: snapshot.data ?? false ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ),
        ListTile(
          title: const Text('Push-to-Start サポート'),
          subtitle: const Text('iOS 17.2+'),
          trailing: FutureBuilder<bool>(
            future: liveActivities.allowsPushStart(),
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? false ? '対応' : '非対応',
                style: TextStyle(
                  color: snapshot.data ?? false ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PushToStartTokenSection extends StatefulWidget {
  const _PushToStartTokenSection({required this.liveActivities});

  final LiveActivities liveActivities;

  @override
  State<_PushToStartTokenSection> createState() =>
      _PushToStartTokenSectionState();
}

class _PushToStartTokenSectionState extends State<_PushToStartTokenSection> {
  String? _token;
  var _isLoading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            _token != null ? Icons.key : Icons.key_off,
            color: _token != null ? Colors.green : Colors.grey,
          ),
          title: const Text('Push-to-Start Token'),
          subtitle: _token != null
              ? SelectableText(
                  _token!,
                  style: const TextStyle(
                    fontFamily: 'NotoSansMono',
                    fontSize: 10,
                  ),
                  maxLines: 3,
                )
              : Text(
                  _error ?? 'トークンを取得してください',
                  style: TextStyle(
                    color: _error != null ? Colors.red : null,
                  ),
                ),
          isThreeLine: _token != null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _listenForToken,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.play_arrow),
                  label: const Text('トークンを取得'),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _token != null ? _copyToken : null,
                icon: const Icon(Icons.copy),
                tooltip: 'コピー',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _listenForToken() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final allowsPushStart = await widget.liveActivities.allowsPushStart();
      if (!allowsPushStart) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _error = 'Push-to-Startは非対応です（iOS 17.2+が必要）';
          });
        }
        return;
      }

      // トークンストリームを1回だけ取得
      await for (final token
          in widget.liveActivities.pushToStartTokenUpdateStream) {
        if (mounted) {
          setState(() {
            _token = token;
            _isLoading = false;
          });
        }
        break; // 最初のトークンを取得したら終了
      }
    } on Exception catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString();
        });
      }
    }
  }

  Future<void> _copyToken() async {
    if (_token == null) return;

    await Clipboard.setData(ClipboardData(text: _token!));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('トークンをコピーしました'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}

class _EewLiveActivitySection extends StatelessWidget {
  const _EewLiveActivitySection({required this.liveActivities});

  final LiveActivities liveActivities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.warning_amber, color: Colors.red),
          title: const Text('EEW（警報）を開始'),
          subtitle: const Text('石川県能登地方 M7.6 震度7'),
          onTap: () => _startEewActivity(context, isWarning: true),
        ),
        ListTile(
          leading: const Icon(Icons.warning_amber, color: Colors.orange),
          title: const Text('EEW（予報）を開始'),
          subtitle: const Text('茨城県沖 M4.2 震度3'),
          onTap: () => _startEewActivity(context, isWarning: false),
        ),
      ],
    );
  }

  Future<void> _startEewActivity(
    BuildContext context, {
    required bool isWarning,
  }) async {
    final eventId = DateTime.now().millisecondsSinceEpoch.toString();

    final data = <String, dynamic>{
      'eventId': eventId,
      'type': 'eew',
      'hypocenterName': isWarning ? '石川県能登地方' : '茨城県沖',
      'magnitude': isWarning ? 7.6 : 4.2,
      'depth': isWarning ? 16 : 40,
      'originTime': DateTime.now().toIso8601String(),
      'maxIntensity': isWarning ? '7' : '3',
      'serialNo': 1,
      'isFinal': false,
      'isWarning': isWarning,
    };

    if (isWarning) {
      data['location'] = <String, dynamic>{
        'regionName': '東京都23区',
        'forecastIntensity': '5-',
        'forecastLpgmIntensity': '2',
        'arrivalTime': DateTime.now()
            .add(const Duration(seconds: 30))
            .toIso8601String(),
      };
    }

    try {
      final activityId = await liveActivities.createActivity(
        eventId,
        data,
        staleIn: const Duration(minutes: 10),
        removeWhenAppIsKilled: true,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Live Activity開始: $activityId'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _ShakeDetectionLiveActivitySection extends StatelessWidget {
  const _ShakeDetectionLiveActivitySection({required this.liveActivities});

  final LiveActivities liveActivities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.waving_hand, color: Colors.orange),
          title: const Text('揺れ検知（強い揺れ）を開始'),
          subtitle: const Text('東京都23区'),
          onTap: () => _startShakeDetectionActivity(context, level: 'Strong'),
        ),
        ListTile(
          leading: const Icon(Icons.waving_hand, color: Colors.blue),
          title: const Text('揺れ検知（弱い揺れ）を開始'),
          subtitle: const Text('神奈川県東部'),
          onTap: () => _startShakeDetectionActivity(context, level: 'Weak'),
        ),
      ],
    );
  }

  Future<void> _startShakeDetectionActivity(
    BuildContext context, {
    required String level,
  }) async {
    final eventId = 'shake-${DateTime.now().millisecondsSinceEpoch}';

    final data = <String, dynamic>{
      'eventId': eventId,
      'type': 'shake_detection',
      'level': level,
      'detectedAt': DateTime.now().toIso8601String(),
      'location': <String, dynamic>{
        'regionName': level == 'Strong' ? '東京都23区' : '神奈川県東部',
        'intensity': level == 'Strong' ? 3.2 : 0.8,
      },
    };

    try {
      final activityId = await liveActivities.createActivity(
        eventId,
        data,
        staleIn: const Duration(minutes: 10),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Live Activity開始: $activityId'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _ActiveActivitiesSection extends StatefulWidget {
  const _ActiveActivitiesSection({required this.liveActivities});

  final LiveActivities liveActivities;

  @override
  State<_ActiveActivitiesSection> createState() =>
      _ActiveActivitiesSectionState();
}

class _ActiveActivitiesSectionState extends State<_ActiveActivitiesSection> {
  List<String> _activityIds = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final ids = await widget.liveActivities.getAllActivitiesIds();
    if (mounted) {
      setState(() {
        _activityIds = ids;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.refresh),
          title: const Text('リストを更新'),
          onTap: _loadActivities,
        ),
        if (_activityIds.isEmpty)
          const ListTile(
            title: Text('アクティブなLive Activityはありません'),
            enabled: false,
          )
        else
          ..._activityIds.map(
            (id) => ListTile(
              title: Text(id),
              trailing: IconButton(
                icon: const Icon(Icons.stop, color: Colors.red),
                onPressed: () => _endActivity(id),
              ),
            ),
          ),
        ListTile(
          leading: const Icon(Icons.stop_circle, color: Colors.red),
          title: const Text('すべてのLive Activityを終了'),
          onTap: _endAllActivities,
        ),
      ],
    );
  }

  Future<void> _endActivity(String activityId) async {
    try {
      await widget.liveActivities.endActivity(activityId);
      await _loadActivities();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Live Activityを終了しました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _endAllActivities() async {
    try {
      await widget.liveActivities.endAllActivities();
      await _loadActivities();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('すべてのLive Activityを終了しました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
