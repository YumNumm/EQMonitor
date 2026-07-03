# AppIntentExtension ターゲット（Xcode テンプレート生成）の設定を
# WidgetExtension と整合させるワンショットスクリプト。
#   ruby scripts/fix_appintent_extension_settings.rb
require 'xcodeproj'

project = Xcodeproj::Project.open(File.expand_path('../Runner.xcodeproj', __dir__))
target = project.targets.find { |t| t.name == 'AppIntentExtension' }
raise 'AppIntentExtension target not found' unless target

# APP_ID_SUFFIX 等の供給元（Widget/Fcm と同じ base configuration）
env_xcconfig = project.files.find { |f| f.real_path.to_s.end_with?('Flutter/Environment.xcconfig') }
raise 'Environment.xcconfig file ref not found' unless env_xcconfig

target.build_configurations.each do |config|
  config.base_configuration_reference = env_xcconfig
  config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] =
    'net.yumnumm.eqmonitor${APP_ID_SUFFIX}.AppIntentExtension'
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '26.0'
  config.build_settings['CODE_SIGN_ENTITLEMENTS'] = 'AppIntentExtension.entitlements'
end

pkg = project.root_object.package_references.find { |r| r.display_name.include?('EQMonitorAPI') }
raise 'EQMonitorAPI package reference not found' unless pkg

unless target.package_product_dependencies.any? { |d| d.product_name == 'EQMonitorAPI' }
  dep = project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
  dep.product_name = 'EQMonitorAPI'
  dep.package = pkg
  target.package_product_dependencies << dep
  # frameworks build phase へ product dependency を接続
  bf = project.new(Xcodeproj::Project::Object::PBXBuildFile)
  bf.product_ref = dep
  target.frameworks_build_phase.files << bf
end

project.save
puts 'done'
