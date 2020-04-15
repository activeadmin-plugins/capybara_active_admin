# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.1] - 2020-04-15
### Added
 - `within_attribute_row` finder

### Removed
 - `find_input` finder
 - `have_input`, `have_no_input` matchers
 - `input_selector` selector

## [0.3.0] - 2020-04-15
### Added
 - implement DSL for tabs, batch actions, modal dialog, attributes table, panel, sidebar, footer
 - improve form DSL

## [0.2.1] - 2020-04-14
### Fixed
 - `table_selector`, `within_table_for` incorrect resource name

### Changed
 - `table_selector` receives 2 arguments
 - `within_table_for` receives 2 arguments
 - `current_table_name` renamed to `current_table_model_name`
 - `table_row_selector` can receive modal class as model name
 
# Added
 - `have_table` matcher
 - add tests for table with namespaced resource class and multi-word resource name

## [0.2.0] - 2020-04-14
### Changed
 - rename `have_table_col` to `have_table_cell`
 - change options of `have_table_cell`
 - change options of `have_table_row`
 - refactor modules hierarchy: split DSL into selectors, finders, matchers and actions

### Added
 - form DSL
 - changelog
 - follow semver

## [0.1.0] - 2020-04-14
### Added
 - travic CI
 - rubocop
 - capybara DSL to check page title, action items, table columns/rows
