import { createFileRoute, Link } from "@tanstack/react-router";

export const Route = createFileRoute("/typography")({
  component: Typography,
});

const typeScale = [
  {
    name: "displayLarge",
    size: "40",
    line: "48",
    weight: "600",
    use: "フルスクリーンの歓迎画面、重大導線の大見出し",
  },
  {
    name: "displayMedium",
    size: "36",
    line: "44",
    weight: "600",
    use: "オンボーディング上部、印象的な 2 行見出し",
  },
  {
    name: "headlineLarge",
    size: "32",
    line: "40",
    weight: "600",
    use: "ページタイトル、シートの大見出し",
  },
  { name: "headlineMedium", size: "28", line: "36", weight: "600", use: "セクション主見出し" },
  {
    name: "headlineSmall",
    size: "24",
    line: "30",
    weight: "600",
    use: "ボトムシートやカード群のタイトル",
  },
  {
    name: "titleLarge",
    size: "22",
    line: "28",
    weight: "600",
    use: "画面上部タイトル、重要カードのタイトル",
  },
  {
    name: "titleMedium",
    size: "18",
    line: "24",
    weight: "600",
    use: "セクションカードの見出し、リストグループタイトル",
  },
  {
    name: "titleSmall",
    size: "16",
    line: "22",
    weight: "600",
    use: "ListTile タイトル、フォーム見出し",
  },
  { name: "bodyLarge", size: "16", line: "24", weight: "400", use: "標準本文、説明文" },
  { name: "bodyMedium", size: "14", line: "20", weight: "400", use: "補助本文、カード内説明" },
  { name: "bodySmall", size: "13", line: "18", weight: "400", use: "注記、サブコピー、メタ情報" },
  {
    name: "labelLarge",
    size: "14",
    line: "20",
    weight: "500",
    use: "ボタン、セグメント、主要ラベル",
  },
  {
    name: "labelMedium",
    size: "12",
    line: "16",
    weight: "500",
    use: "バッジ、補助ラベル、フィルタ",
  },
  { name: "labelSmall", size: "11", line: "14", weight: "500", use: "キャプション、極小メタ情報" },
];

const monoScale = [
  {
    name: "monoLarge",
    size: "16",
    line: "22",
    weight: "500",
    use: "緯度経度、ID、設定値、観測数値",
  },
  {
    name: "monoMedium",
    size: "14",
    line: "20",
    weight: "500",
    use: "ログ、時刻、バージョン、診断情報",
  },
  {
    name: "monoSmall",
    size: "12",
    line: "16",
    weight: "500",
    use: "チップ内メタ情報、小さな数値ラベル",
  },
];

function Typography() {
  return (
    <div className="p-8 max-w-6xl mx-auto">
      <header className="mb-12">
        <Link to="/" className="text-brand-primary hover:underline flex items-center mb-4">
          <span className="material-icons mr-1">arrow_back</span> Back to Home
        </Link>
        <h1 className="text-4xl font-bold">Typography</h1>
      </header>

      <section className="mb-16">
        <h2 className="text-2xl font-semibold mb-8">Type Scale (Google Sans Flex)</h2>
        <div className="space-y-12">
          {typeScale.map((item) => (
            <div
              key={item.name}
              className="flex flex-col md:flex-row md:items-start border-b border-outline-soft pb-8"
            >
              <div className="md:w-64 mb-4 md:mb-0">
                <p className="text-brand-secondary font-mono text-sm mb-1">{item.name}</p>
                <p className="text-text-tertiary text-xs uppercase tracking-wider">
                  {item.size}/{item.line} • {item.weight}
                </p>
              </div>
              <div className="flex-1">
                <p
                  style={{
                    fontSize: `${item.size}px`,
                    lineHeight: `${item.line}px`,
                    fontWeight: item.weight,
                  }}
                  className="mb-2"
                >
                  The quick brown fox jumps over the lazy dog.
                </p>
                <p className="text-text-secondary text-sm">
                  <span className="font-semibold">Use:</span> {item.use}
                </p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <section className="mb-16">
        <h2 className="text-2xl font-semibold mb-8">Numeric and Code Styles (Google Sans Code)</h2>
        <div className="space-y-12">
          {monoScale.map((item) => (
            <div
              key={item.name}
              className="flex flex-col md:flex-row md:items-start border-b border-outline-soft pb-8"
            >
              <div className="md:w-64 mb-4 md:mb-0">
                <p className="text-brand-secondary font-mono text-sm mb-1">{item.name}</p>
                <p className="text-text-tertiary text-xs uppercase tracking-wider">
                  {item.size}/{item.line} • {item.weight}
                </p>
              </div>
              <div className="flex-1">
                <p
                  style={{
                    fontSize: `${item.size}px`,
                    lineHeight: `${item.line}px`,
                    fontWeight: item.weight,
                  }}
                  className="font-mono mb-2"
                >
                  35.6895, 139.6917 - 2023/10/27 10:45:12
                </p>
                <p className="text-text-secondary text-sm">
                  <span className="font-semibold">Use:</span> {item.use}
                </p>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
