DELETE FROM mno_id_map;
DELETE FROM system_log;
DELETE FROM system_log_detail;
DELETE FROM users;
DELETE FROM permission_user;
DELETE FROM user_preference;
DELETE FROM user_title;
DELETE FROM branch;
DELETE FROM user_wage;
DELETE FROM punch_control;
DELETE FROM punch;
DELETE FROM pay_period_schedule;
DELETE FROM pay_period;
DELETE FROM pay_stub_entry_account WHERE id > 75;
DELETE FROM pay_code WHERE id > 32;
DELETE FROM user_date;
DELETE FROM user_date_total;
