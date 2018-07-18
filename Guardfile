guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^locale/(.+)\.pot?$})  { "spec" }
  watch(%r{^spec/(.+)\.rb$})  { "spec" }
  watch(%r{^db/(.+)\.rb$})  { "spec" }
  watch(%r{^lib/(.+)\.e?rb$}) { "spec" }
end
