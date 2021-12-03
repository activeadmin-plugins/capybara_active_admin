# frozen_string_literal: true

require 'bundler/inline'

require 'active_record'
require 'sassc-rails'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Base.logger = if ENV['CI']
                              ActiveSupport::Logger.new(STDOUT)
                            else
                              ActiveSupport::Logger.new(File.join(__dir__, 'log/test.log'))
                            end

ActiveRecord::Schema.define do
  create_table :active_admin_comments do |t|
    t.string :namespace
    t.text :body
    t.references :resource, polymorphic: true
    t.references :author, polymorphic: true
    t.timestamps
  end

  create_table :users, force: true do |t|
    t.string :full_name
    t.timestamps
  end

  create_table :employees, force: true do |t|
    t.string :full_name
    t.decimal :salary
    t.timestamps
  end

  create_table :duties, force: true do |t|
    t.string :name
    t.string :duty_type
    t.integer :employee_id
    t.timestamps
  end
end

require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'active_admin'

class TestApplication < Rails::Application
  config.root = __dir__
  config.session_store :cookie_store, key: 'cookie_store_key'
  secrets.secret_token = 'secret_token'
  secrets.secret_key_base = 'secret_key_base'

  config.eager_load = false
  config.logger = ActiveRecord::Base.logger

  config.hosts = %w[127.0.0.1]

  # Configure sprockets assets
  config.assets.paths = [File.join(config.root, 'assets')]
  config.assets.unknown_asset_fallback = false
  config.assets.digest = false
  config.assets.debug = false
  config.assets.compile = true
  # config.public_file_server.enabled
end

class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers

  rescue_from StandardError, with: :render_server_error

  def render_server_error(error)
    log_error(error)
    respond_with do |format|
      # we will see exceptions in failed screenshots
      format.html do
        msg = "<h2>#{error.class}: #{error.message}<h2>"
        bt = error.backtrace.map { |line| "<div>#{line}</div>" }
        html = "<h1>Something went wrong</h1>#{msg}#{bt.join}".html_safe
        render status: 500, html: html
      end
      format.json do
        render status: 500, json: { error: 'server_error' }
      end
    end
  end

  def log_error(error, causes: [])
    logger.error { "<#{error.class}>: #{error.message}\n#{error.backtrace.join("\n")}" }
    return if error.cause.nil? || error.cause == error || causes.include?(error.cause)

    causes.push(error)
    log_error(error, causes)
  end
end

class User < ActiveRecord::Base
  validates :full_name, presence: true
end

module Billing
  class Employee < ActiveRecord::Base
    has_many :duties, class_name: 'Billing::Duty'
    accepts_nested_attributes_for :duties
    validates :full_name, presence: true
    validates :salary, numericality: { greater_than_or_equal_to: 0.01 }
  end

  class Duty < ActiveRecord::Base
    belongs_to :employee, class_name: 'Billing::Employee'
    validates :name, presence: true
    validates :duty_type, inclusion: { in: %w[common extra] }

    def common?
      duty_type == 'common'
    end
  end
end

ActiveAdmin.setup do |config|
  # Disabling authentication in specs so that we don't have to worry about
  # it allover the place
  config.authentication_method = false
  config.current_user_method = false
  config.batch_actions = true
end

Rails.application.initialize!
# to execute prepare hooks
ActiveSupport::Reloader.prepare!

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }
  content do
    'Test Me'
  end
end

ActiveAdmin.register User do
  permit_params :full_name
end

ActiveAdmin.register Billing::Employee, as: 'Business Employee' do
  permit_params :full_name, :salary, duties_attributes: [:id, :name, :duty_type]
  includes :duties

  batch_action :update_salary, form: -> { { salary: :text } } do |ids, inputs|
    batch_action_collection.where(id: ids).each { |r| r.update!(salary: inputs['salary']) }
    flash[:notice] = 'Salary was updated successfully'
    redirect_back(fallback_location: admin_root_path)
  end

  index do
    actions
    id_column
    selectable_column
    column :full_name
    column(:salary) { |r| number_to_currency(r.salary) }
    column(:common_duties) { |r| r.duties.select(&:common?).map(&:name).join(', ') }
    column(:extra_duties) { |r| r.duties.reject(&:common?).map(&:name).join(', ') }
    column :created_at
    column :updated_at
  end

  show do
    tabs do
      tab 'Details' do
        attributes_table do
          row :id
          row :full_name
          row(:salary) { |r| number_to_currency(r.salary) }
          row :created_at
          row :updated_at
        end
      end

      tab 'Duties' do
        table_for resource.duties, class: 'index_table' do
          column :id
          column :name
          column :type, :duty_type
          column :created_at
          column :updated_at
        end
      end
    end
  end

  form do |f|
    f.semantic_errors(*f.object.errors.full_messages)

    f.inputs do
      f.input :full_name
      f.input :salary
    end

    f.has_many :duties do |d|
      d.input :name
      d.input :duty_type, label: 'Type', as: :select, collection: %w[common extra]
    end

    f.actions
  end
end

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
end
