import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThanksWidget extends StatelessWidget {
  const ThanksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    const titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
    return ExpandablePanel(
      theme: ExpandableThemeData(
        hasIcon: true,
        iconColor: t.iconTheme.color,
        iconPadding: const EdgeInsets.symmetric(vertical: 16),
        animationDuration: const Duration(milliseconds: 300),
      ),
      header: const ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Text('Special Thanks', style: titleTextStyle),
        leading: Icon(Icons.favorite),
      ),
      collapsed: const SizedBox.shrink(),
      expanded: Padding(
        padding: const EdgeInsets.all(12),
        child: Card(
          color: t.colorScheme.secondaryContainer.withOpacity(0.4),
          elevation: 0,
          child: Column(
            children: const [
              ThanksItem(
                title: 'Project DM-D.S.S',
                description: '緊急地震速報等の地震情報',
                url: 'https://dmdata.jp/',
              ),
              ThanksItem(
                title: 'François LN / フランソワ (JQuake)氏',
                description: '強震モニタ画像解析手法',
                url: 'https://qiita.com/NoneType1/items/a4d2cf932e20b56ca444',
              ),
              ThanksItem(
                title: '国立研究開発法人 防災科学技術研究所',
                description: 'リアルタイム震度データ',
                url:
                    'https://www.kyoshin.bosai.go.jp/kyoshin/docs/new_kyoshinmonitor.html',
              ),
              ThanksItem(
                title: 'Cateiru氏',
                description: '通知用の震度分布図生成ソフトウェア',
                url: 'https://github.com/earthquake-alert/earthquake-alert',
              ),
              ThanksItem(
                title: '国土交通省 気象庁',
                description: '予報区等GISデータをGeoJSON形式に変換し利用',
                url: 'https://www.data.jma.go.jp/developer/gis.html',
              ),
              ThanksItem(
                title: 'および 全ての関係者に感謝いたします。',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThanksItem extends StatelessWidget {
  const ThanksItem({
    this.icon,
    required this.title,
    this.description,
    this.url,
    super.key,
  });

  final Widget? icon;
  final String title;
  final String? description;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        width: 48,
        child: Center(
          child: icon,
        ),
      ),
      title: Text(
        title,
        style: t.textTheme.bodyMedium!.copyWith(
          color: t.colorScheme.onSecondaryContainer,
        ),
      ),
      subtitle: description != null
          ? Text(
              description!,
              style: t.textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
      onTap: () => url != null
          ? launchUrl(
              Uri.parse(url!),
              mode: LaunchMode.externalApplication,
            )
          : null,
    );
  }
}
