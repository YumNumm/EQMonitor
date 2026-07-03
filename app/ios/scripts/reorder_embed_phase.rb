# Flutter の Thin Binary スクリプトフェーズより後に Embed ExtensionKit Extensions が
# あると依存循環 (Cycle inside Runner) になるため、embed フェーズを前へ移動する。
#   ruby scripts/reorder_embed_phase.rb
require 'xcodeproj'

project = Xcodeproj::Project.open(File.expand_path('../Runner.xcodeproj', __dir__))
runner = project.targets.find { |t| t.name == 'Runner' }

phases = runner.build_phases
embed = phases.find { |p| p.respond_to?(:name) && p.name == 'Embed ExtensionKit Extensions' }
thin = phases.find { |p| p.respond_to?(:name) && p.name == 'Thin Binary' }
raise 'phase not found' unless embed && thin

embed_index = phases.index(embed)
thin_index = phases.index(thin)
if embed_index > thin_index
  phases.delete(embed)
  phases.insert(phases.index(thin), embed)
  project.save
  puts "moved: #{phases.map { |p| p.respond_to?(:name) ? p.name : p.class.to_s.split('::').last }.compact.join(' -> ')}"
else
  puts 'already ordered'
end
