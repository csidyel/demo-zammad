# Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

require 'rails_helper'

RSpec.describe SystemReport, current_user_id: 1, type: :model do
  describe 'fetch' do
    it 'generates system report' do
      expect(described_class.fetch[:system_report]).to include({
                                                                 'Version' => Version.get,
                                                               })
    end

    describe 'settings plugin' do
      let(:non_confidential_settings) do
        [
          'ui_ticket_priority_icons',
          'kb_multi_lingual_support',
          'kb_active',
          'kb_active_publicly',
          'ui_ticket_zoom_article_delete_timeframe',
          'es_total_max_size_in_mb',
          'system_init_done',
          'maintenance_mode',
          'maintenance_login',
          'maintenance_login_message',
          'developer_mode',
          'system_online_service',
          'product_name',
          'product_logo',
          'organization',
          'locale_default',
          'timezone_default',
          'pretty_date_format',
          'ui_ticket_zoom_article_note_new_internal',
          'ui_ticket_zoom_article_visibility_confirmation_dialog',
          'ui_ticket_zoom_article_email_subject',
          'system_id',
          'fqdn',
          'websocket_backend',
          'websocket_port',
          'http_type',
          'storage_provider',
          'image_backend',
          'geo_ip_backend',
          'geo_location_backend',
          'geo_calendar_backend',
          'proxy',
          'proxy_username',
          'proxy_no',
          'core_workflow_ajax_mode',
          'ui_user_organization_selector_with_email',
          'ui_ticket_zoom_article_email_full_quote',
          'ui_ticket_zoom_article_email_full_quote_header',
          'ui_ticket_zoom_article_twitter_initials',
          'ui_ticket_zoom_attachments_preview',
          'ui_ticket_zoom_sidebar_article_attachments',
          'ui_ticket_create_notes',
          'ui_ticket_create_default_type',
          'ui_ticket_create_available_types',
          'ui_sidebar_open_ticket_indicator_colored',
          'ui_table_group_by_show_count',
          'ui_ticket_overview_ticket_limit',
          'ui_task_mananger_max_task_count',
          'user_create_account',
          'session_timeout',
          'user_email_multiple_use',
          'form_ticket_create_per_day',
          'app_version',
          'ticket_hook',
          'ticket_hook_divider',
          'ticket_hook_position',
          'ticket_last_contact_behaviour',
          'ticket_allow_expert_conditions',
          'ticket_conditions_allow_regular_expression_operators',
          'ticket_number',
          'ticket_number_increment',
          'ticket_number_date',
          'ticket_auto_assignment',
          'ticket_auto_assignment_selector',
          'ticket_auto_assignment_user_ids_ignore',
          'ticket_agent_default_notifications',
          'ticket_subject_size',
          'ticket_duplicate_detection',
          'ticket_duplicate_detection_attributes',
          'ticket_duplicate_detection_title',
          'ticket_duplicate_detection_body',
          'ticket_duplicate_detection_role_ids',
          'ticket_duplicate_detection_show_tickets',
          'ticket_duplicate_detection_permission_level',
          'ticket_duplicate_detection_search',
          'ticket_number_ignore_system_id',
          'ticket_trigger_recursive',
          'ticket_trigger_loop_protection_articles_per_ticket',
          'ticket_trigger_loop_protection_articles_total',
          'ticket_trigger_recursive_max_loop',
          'customer_ticket_create',
          'customer_ticket_create_group_ids',
          'ticket_secondary_action',
          'form_ticket_create',
          'form_ticket_create_group_id',
          'form_ticket_create_by_ip_per_hour',
          'form_ticket_create_by_ip_per_day',
          'ticket_subject_re',
          'ticket_subject_fwd',
          'ticket_define_email_from',
          'ticket_define_email_from_separator',
          'postmaster_max_size',
          'postmaster_follow_up_search_in',
          'postmaster_sender_based_on_reply_to',
          'postmaster_sender_is_agent_search_for_customer',
          'postmaster_send_reject_if_mail_too_large',
          'notification_sender',
          'send_no_auto_response_reg_exp',
          'system_bcc',
          'chat',
          'chat_agent_idle_timeout',
          'default_controller',
          'es_url',
          'es_user',
          'es_index',
          'es_ssl_verify',
          'es_attachment_ignore',
          'es_attachment_max_size_in_mb',
          'es_pipeline',
          'es_model_settings',
          'import_mode',
          'import_backend',
          'import_ignore_sla',
          'import_otrs_endpoint',
          'import_otrs_user',
          'import_zendesk_endpoint',
          'import_zendesk_endpoint_username',
          'import_freshdesk_endpoint',
          'import_kayako_endpoint',
          'import_kayako_endpoint_username',
          'import_backends',
          'sequencer_log_level',
          'time_accounting',
          'time_accounting_selector',
          'time_accounting_unit',
          'time_accounting_unit_custom',
          'time_accounting_types',
          'time_accounting_type_default',
          'tag_new',
          'defaults_calendar_subscriptions_tickets',
          '0005_postmaster_filter_trusted',
          '0006_postmaster_filter_auto_response_check',
          '0007_postmaster_filter_follow_up_check',
          '0008_postmaster_filter_follow_up_merged',
          '0009_postmaster_filter_follow_up_assignment',
          '0011_postmaster_sender_based_on_reply_to',
          '0018_postmaster_import_archive',
          '0012_postmaster_filter_sender_is_system_address',
          '0014_postmaster_filter_own_notification_loop_detection',
          '0015_postmaster_filter_identify_sender',
          '0016_postmaster_filter_secure_mailing',
          '0030_postmaster_filter_out_of_office_check',
          '0200_postmaster_filter_follow_up_possible_check',
          '0900_postmaster_filter_bounce_follow_up_check',
          '0950_postmaster_filter_bounce_delivery_permanent_failed',
          '0955_postmaster_filter_bounce_delivery_temporary_failed',
          '1000_postmaster_filter_database_check',
          '5000_postmaster_filter_icinga',
          '5100_postmaster_filter_nagios',
          '5300_postmaster_filter_monit',
          '5400_postmaster_filter_service_now_check',
          '5401_postmaster_filter_service_now_check',
          '5400_postmaster_filter_jira_check',
          '5401_postmaster_filter_jira_check',
          '5500_postmaster_internal_article_check',
          'icinga_integration',
          'icinga_sender',
          'icinga_auto_close',
          'icinga_auto_close_state_id',
          'nagios_integration',
          'nagios_sender',
          'nagios_auto_close',
          'nagios_auto_close_state_id',
          'check_mk_integration',
          'check_mk_group_id',
          'check_mk_auto_close',
          'check_mk_auto_close_state_id',
          'monit_integration',
          'monit_sender',
          'monit_auto_close',
          'monit_auto_close_state_id',
          'ldap_integration',
          'exchange_oauth',
          'exchange_integration',
          'idoit_integration',
          'gitlab_integration',
          'github_integration',
          '0100_trigger',
          '0100_notification',
          '1000_signature_detection',
          '6000_slack_webhook',
          'slack_integration',
          'sipgate_integration',
          'sipgate_alternative_fqdn',
          'cti_integration',
          'cti_customer_last_activity',
          'placetel_integration',
          'clearbit_integration',
          '9000_clearbit_enrichment',
          '9100_cti_caller_id_detection',
          '9200_time_based_trigger',
          'system_agent_limit',
          'html_email_css_font',
          'html_sanitizer_processing_timeout',
          'Stats::TicketWaitingTime',
          'Stats::TicketEscalation',
          'Stats::TicketChannelDistribution',
          'Stats::TicketLoadMeasure',
          'Stats::TicketInProcess',
          'Stats::TicketReopen',
          'ui_ticket_add_article_hint',
          'smime_integration',
          'pgp_integration',
          'datepicker_show_calendar_weeks',
          'two_factor_authentication_method_security_keys',
          'two_factor_authentication_method_authenticator_app',
          'two_factor_authentication_enforce_role_ids',
          'ticket_organization_reassignment',
          'checklist',
          'auto_shutdown',
        ]
      end

      it 'does not return confidential settings' do

        # This test will always fail if you add new settings.
        # If your setting does not contain confidential values, just add it to the non_confidential_settings variable list in the top.
        # If your setting DOES contain confidential values, then edit the settings plugin of the system report to exclude it.
        settings = described_class.fetch[:system_report]['Setting'].pluck(:name)
        expect((settings - non_confidential_settings)).to eq([])
      end
    end
  end
end
