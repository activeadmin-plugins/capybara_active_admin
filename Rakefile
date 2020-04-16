# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'yard/rake/yardoc_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop)
YARD::Rake::YardocTask.new(:yard) do |task|
  task.options += [
      %(--output-dir=./docs/.vuepress/public/api/),
      %(--title=Capybara Active Admin API Reference)
  ]
end

task default: [:rubocop, :spec]
