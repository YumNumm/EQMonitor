# Widget の表示用モデル/サービスを Shared/ (通常グループ) に移し、
# WidgetExtension / AppIntentExtension / WidgetModelsTests の3ターゲットで共有する。
# Widget/ と AppIntentExtension/ は synchronized folder のため個別ファイルの
# ターゲットメンバーシップ共有ができず、明示的な file reference が必要。
#   ruby scripts/setup_shared_sources.rb
require 'xcodeproj'

project = Xcodeproj::Project.open(File.expand_path('../Runner.xcodeproj', __dir__))
widget = project.targets.find { |t| t.name == 'WidgetExtension' }
intents = project.targets.find { |t| t.name == 'AppIntentExtension' }
raise 'targets not found' unless widget && intents

SHARED_FILES = %w[
  EarthquakeDisplayItem.swift
  IntensityValue.swift
  TelegramStatus.swift
  WidgetRegionResolver.swift
  EarthquakeAPIClient.swift
  RegionType.swift
  ColorRGB.swift
].freeze

# テストはフォーマットロジックのみ対象（APIクライアントは含めない）
TEST_COMPILED = %w[
  EarthquakeDisplayItem.swift
  IntensityValue.swift
  TelegramStatus.swift
  WidgetRegionResolver.swift
  RegionType.swift
  ColorRGB.swift
].freeze

shared_group = project.main_group['Shared'] || project.main_group.new_group('Shared', 'Shared')
refs = SHARED_FILES.map { |f| shared_group.files.find { |r| r.path == f } || shared_group.new_file(f) }

[widget, intents].each do |target|
  existing = target.source_build_phase.files_references
  refs.each { |ref| target.source_build_phase.add_file_reference(ref) unless existing.include?(ref) }
end

unless project.targets.any? { |t| t.name == 'WidgetModelsTests' }
  test_target = project.new_target(:unit_test_bundle, 'WidgetModelsTests', :ios, '26.0')
  test_target.build_configurations.each do |config|
    config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'net.yumnumm.eqmonitor.WidgetModelsTests'
    config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
    config.build_settings['SWIFT_VERSION'] = '5.0'
    config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '26.0'
    config.build_settings["PRODUCT_NAME"] = "$(TARGET_NAME)"
  end

  test_refs = refs.select { |r| TEST_COMPILED.include?(r.path) }
  test_group = project.main_group.new_group('WidgetModelsTests', 'WidgetModelsTests')
  test_refs << test_group.new_file('EarthquakeDisplayItemTests.swift')
  test_target.add_file_references(test_refs)

  pkg = project.root_object.package_references.find { |r| r.display_name.include?('EQMonitorAPI') }
  raise 'EQMonitorAPI package reference not found' unless pkg
  dep = project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
  dep.product_name = 'EQMonitorAPI'
  dep.package = pkg
  test_target.package_product_dependencies << dep
  bf = project.new(Xcodeproj::Project::Object::PBXBuildFile)
  bf.product_ref = dep
  test_target.frameworks_build_phase.files << bf

  project.save
  scheme = Xcodeproj::XCScheme.new
  scheme.add_test_target(test_target)
  scheme.save_as(project.path, 'WidgetModelsTests', true)
else
  project.save
end
puts 'done'
