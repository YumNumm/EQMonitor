# DesignTokens.swift を WidgetExtension / AppIntentExtension へ配線し、
# GoogleSans 可変フォント (app/assets/fonts/ への参照) を
# AppIntentExtension のリソースへ追加するワンショットスクリプト。
#   ruby scripts/add_design_resources.rb
require 'xcodeproj'

project = Xcodeproj::Project.open(File.expand_path('../Runner.xcodeproj', __dir__))
widget = project.targets.find { |t| t.name == 'WidgetExtension' }
intents = project.targets.find { |t| t.name == 'AppIntentExtension' }

shared = project.main_group['Shared']
tokens = shared.files.find { |r| r.path == 'DesignTokens.swift' } || shared.new_file('DesignTokens.swift')
[widget, intents].each do |target|
  unless target.source_build_phase.files_references.include?(tokens)
    target.source_build_phase.add_file_reference(tokens)
  end
end

# フォント（Flutter アセットへの参照。拡張からアプリ本体の flutter_assets は
# 読めないため、拡張バンドルに個別に同梱する）
fonts_group = project.main_group['Fonts'] || project.main_group.new_group('Fonts')
font_paths = [
  '../assets/fonts/GoogleSansFlex/GoogleSansFlex[GRAD,ROND,opsz,slnt,wdth,wght].ttf',
  '../assets/fonts/GoogleSansCode/GoogleSansCode[MONO,wght].ttf',
]
font_paths.each do |p|
  ref = fonts_group.files.find { |r| r.path == p } || fonts_group.new_file(p)
  unless intents.resources_build_phase.files_references.include?(ref)
    intents.resources_build_phase.add_file_reference(ref)
  end
end

project.save
puts 'done'

# 追記: jma_code_table.json（地域選択パラメータ用）も AppIntentExtension の
# リソースへ参照追加する（上のフォントと同じ方式・実行済み）
