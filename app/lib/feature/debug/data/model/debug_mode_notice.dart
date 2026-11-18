enum DebugModeNotice({
  required final String title,
  required final String body,
}) {
  publication(
    title: 'SNS などへの公開の禁止',
    body: 'デバッグ機能の画面や内容を、SNS などへ公開することを禁止します。',
  ),
  liability(
    title: '免責',
    body: 'デバッグ機能の利用によって不具合などが起きても、開発者は一切の責任を負いません。',
  ),
  stability(
    title: '予告のない変更・削除',
    body: 'デバッグ機能は開発者向けのものです。予告なく変更・削除します。',
  ),
}
