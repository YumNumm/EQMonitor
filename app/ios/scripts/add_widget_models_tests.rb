# WidgetModelsTests ユニットテストターゲット（ホストアプリなし）を追加する
# ワンショットスクリプト。Widget の表示用モデルを直接コンパイルしてテストする。
#   ruby scripts/add_widget_models_tests.rb
require 'xcodeproj'

project = Xcodeproj::Project.open(File.expand_path('../Runner.xcodeproj', __dir__))
raise 'already exists' if project.targets.any? { |t| t.name == 'WidgetModelsTests' }

target = project.new_target(:unit_test_bundle, 'WidgetModelsTests', :ios, '26.0')
target.build_configurations.each do |config|
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = 'net.yumnumm.eqmonitor.WidgetModelsTests'
  config.build_settings['GENERATE_INFOPLIST_FILE'] = 'YES'
  config.build_settings['SWIFT_VERSION'] = '5.0'
  config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '26.0'
end

# Widget の表示用モデルをテストターゲットでも直接コンパイルする
shared_paths = %w[
  Widget/Models/EarthquakeDisplayItem.swift
  Widget/Models/IntensityValue.swift
  Widget/Models/TelegramStatus.swift
  Widget/Services/WidgetRegionResolver.swift
]
refs = shared_paths.map do |p|
  project.files.find { |f| f.real_path.to_s.end_with?(p) } || raise("missing file ref: #{p}")
end

group = project.main_group.new_group('WidgetModelsTests', 'WidgetModelsTests')
refs << group.new_file('EarthquakeDisplayItemTests.swift')
target.add_file_references(refs)

# EQMonitorAPI (ローカル SPM) 依存
pkg = project.root_object.package_references.find { |r| r.display_name.include?('EQMonitorAPI') }
raise 'EQMonitorAPI package reference not found' unless pkg
dep = project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
dep.product_name = 'EQMonitorAPI'
dep.package = pkg
target.package_product_dependencies << dep
bf = project.new(Xcodeproj::Project::Object::PBXBuildFile)
bf.product_ref = dep
target.frameworks_build_phase.files << bf

project.save

# 共有スキーム（xcodebuild test 用）
scheme = Xcodeproj::XCScheme.new
scheme.add_test_target(target)
scheme.save_as(project.path, 'WidgetModelsTests', true)
puts 'done'
