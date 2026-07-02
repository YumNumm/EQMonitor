#!/bin/sh

# See: https://github.com/yumemi-inc/flutter-mobile-project-template/blob/6ecefcaeb994ed2ec6bd61341d9e59988167c940/apps/app/ios/scripts/extract_dart_defines.sh

# Dart defineを書き出すファイルパスを指定します。
# ここでは `Environment.xcconfig` というファイル名で作成することにします。
OUTPUT_FILE="${SRCROOT}/Flutter/Environment.xcconfig"
# Dart defineの中身を変更した時に古いプロパティが残らないように、初めにファイルを空にしています。
: > $OUTPUT_FILE

# この関数でDart defineをデコードします。
function decode_url() { echo "${*}" | base64 --decode; }

IFS=',' read -r -a define_items <<<"$DART_DEFINES"

for index in "${!define_items[@]}"
do
    item=$(decode_url "${define_items[$index]}")
    # Dartの定義にはFlutter側で自動定義された項目も含まれます。
    # しかし、それらの定義を書き出してしまうとエラーによりビルドができなくなるので、
    # flutterやFLUTTERで始まる項目は出力しないようにしています。
    lowercase_item=$(echo "$item" | tr '[:upper:]' '[:lower:]')
    if [[ $lowercase_item != flutter* ]]; then
        # xcconfig は `//` 以降を行コメントとして切り捨てるため、URL の `https://`
        # がホスト名ごと欠落する。空変数参照 `$()` を割り込ませてトークンを分断し、
        # 展開後は元の `//` に戻る標準ワークアラウンドを適用する。$() を評価させず
        # リテラルとして書き出すため、変数経由で置換文字列に埋め込む。
        empty_ref='$()'
        item=${item//:\/\//:/${empty_ref}/}
        echo "Extracting environment variable: $item"
        echo "$item" >> "$OUTPUT_FILE"
    fi
done
