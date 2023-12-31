# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do # rubocop:disable Metrics/BlockLength
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel I18n.t('active_admin.statistics.by_day') do
          render partial: 'base_chart',
                 locals: { data: Ahoy::Event.where(time: Time.zone.now.all_day, name: 'Viewed Post')
                                            .group_by_hour(:time).count }
        end

        panel I18n.t('active_admin.statistics.by_week') do
          render partial: 'base_chart',
                 locals: { data: Ahoy::Event.where(time: Time.zone.now.all_week, name: 'Viewed Post')
                                            .group_by_day(:time).count }
        end

        panel I18n.t('active_admin.statistics.by_month') do
          render partial: 'base_chart',
                 locals: { data: Ahoy::Event.where(time: Time.zone.now.all_month, name: 'Viewed Post')
                                            .group_by_day(:time).count }
        end

        panel I18n.t('active_admin.statistics.by_year') do
          render partial: 'base_chart',
                 locals: { data: Ahoy::Event.where(time: Time.zone.now.all_year, name: 'Viewed Post')
                                            .group_by_month(:time).count }
        end

        panel I18n.t('active_admin.statistics.all_time') do
          render partial: 'base_chart',
                 locals: { data: Ahoy::Event.where(name: 'Viewed Post').group_by_year(:time).count }
        end
      end
    end
  end
end
