import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// go_router のルートに `material_ui` の [MaterialPage] を割り当てる mixin。
///
/// [GoRouteData.build] のみを実装するルートにはこの mixin を適用し、
/// [MaterialPage] を明示的に生成する。[Page] に渡すキーやリストア ID・遷移ログ用の
/// 名前は、go_router 本体が既定のページを組み立てるときと同じ値を与える。
mixin MaterialPageMixin on GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage<void>(
        key: state.pageKey,
        name: state.name ?? state.path,
        arguments: <String, String>{
          ...state.pathParameters,
          ...state.uri.queryParameters,
        },
        restorationId: state.pageKey.value,
        child: Builder(builder: (context) => build(context, state)),
      );
}
