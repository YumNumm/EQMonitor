# AppIntentExtension フォルダ（synchronized folder）のソースを WidgetExtension でも
# コンパイルできるようにする（スニペットコントロールが EarthquakeSnippetIntent を
# 参照するため）。@main とAppShortcutsProviderは除外する。
# 併せてスニペット描画に必要なリソース（地域テーブル・フォント）を
# WidgetExtension にも同梱する。
#
# ※注意: xcodeproj gem (1.27) は fileSystemSynchronizedGroups への追記保存時に
#   既存エントリを落とすバグがあり、実際の反映は pbxproj へのテキスト編集で
#   行った（2026-07-03）。このスクリプトは意図の記録であり再実行しないこと。
require 'xcodeproj'

project = Xcodeproj::Project.open(File.expand_path('../Runner.xcodeproj', __dir__))
widget = project.targets.find { |t| t.name == 'WidgetExtension' }
sync_group = project.objects.find do |o|
  o.isa == 'PBXFileSystemSynchronizedRootGroup' && o.path == 'AppIntentExtension'
end
raise 'sync group not found' unless sync_group

unless widget.file_system_synchronized_groups&.include?(sync_group)
  exception = project.new(Xcodeproj::Project::Object::PBXFileSystemSynchronizedBuildFileExceptionSet)
  exception.target = widget
  # WidgetExtension では除外するファイル（エントリポイントと App Shortcuts 定義）
  exception.membership_exceptions = [
    'AppIntentExtension.swift',
    'AppIntentExtensionExtension.swift',
    'Info.plist', # WidgetExtension 自身の Info.plist と衝突するため
  ]
  sync_group.exceptions ||= []
  sync_group.exceptions << exception
  widget.file_system_synchronized_groups ||= []
  widget.file_system_synchronized_groups << sync_group
end

resource_paths = [
  '../assets/parameters/jma_code_table.json',
  '../assets/fonts/GoogleSansFlex/GoogleSansFlex[GRAD,ROND,opsz,slnt,wdth,wght].ttf',
  '../assets/fonts/GoogleSansCode/GoogleSansCode[MONO,wght].ttf',
]
resource_paths.each do |p|
  ref = project.files.find { |f| f.path == p }
  raise "file ref not found: #{p}" unless ref
  unless widget.resources_build_phase.files_references.include?(ref)
    widget.resources_build_phase.add_file_reference(ref)
  end
end

project.save
puts 'done'
