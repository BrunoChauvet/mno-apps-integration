-- Relink Modules and Mno_ID_Map
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM vtiger_crmentity WHERE setype = 'Event';
DELETE FROM vtiger_crmentity WHERE setype = 'Tickets';
DELETE FROM vtiger_entityname WHERE modulename = 'Event';
DELETE FROM vtiger_entityname WHERE modulename = 'Tickets';
DELETE FROM vtiger_ws_entity WHERE name = 'Event';
DELETE FROM vtiger_ws_entity WHERE name = 'Tickets';
DELETE FROM vtiger_customview WHERE entitytype = 'Event';
DELETE FROM vtiger_customview WHERE entitytype = 'Tickets';
DELETE FROM vtiger_tab WHERE name = 'Event';
DELETE FROM vtiger_tab WHERE name = 'Tickets';
DELETE FROM vtiger_field WHERE tablename = 'vtiger_event';
DELETE FROM vtiger_field WHERE tablename = 'vtiger_tickets';
DROP TABLE IF EXISTS vtiger_event;
DROP TABLE IF EXISTS vtiger_eventcf;
DROP TABLE IF EXISTS vtiger_tickets;
DROP TABLE IF EXISTS vtiger_ticketscf;
SET FOREIGN_KEY_CHECKS=1;
UPDATE mno_id_map SET mno_entity_name = 'PERSON' WHERE mno_entity_name = 'PERSONS';
UPDATE mno_id_map SET mno_entity_name = 'ORGANIZATION' WHERE mno_entity_name = 'ORGANIZATIONS';
UPDATE mno_id_map SET mno_entity_name = 'PRODUCT' WHERE mno_entity_name = 'ITEMS';
DELETE FROM mno_id_map WHERE mno_entity_name = 'TICKETS';
DELETE FROM mno_id_map WHERE mno_entity_name = 'EVENTS';

-- Delete deprecated modules
DELETE FROM vtiger_crmentity WHERE setype = 'Mailchimp';
DELETE FROM vtiger_tab WHERE name = 'Mailchimp';

DELETE FROM vtiger_crmentity WHERE setype = 'SQLReports';
DELETE FROM vtiger_tab WHERE name = 'SQLReports';

DELETE FROM vtiger_crmentity WHERE setype = 'SQLReports';
DELETE FROM vtiger_tab WHERE name = 'SQLReports';

DROP TABLE IF EXISTS vtiger_mailchimp;
DROP TABLE IF EXISTS vtiger_mailchimp_settings;
DROP TABLE IF EXISTS vtiger_mailchimpcf;
DROP TABLE IF EXISTS vtiger_mailchimpsyncdiff;

DROP TABLE IF EXISTS vtiger_sqlreports;
DROP TABLE IF EXISTS vtiger_sqlreportscf;

-- Delete duplicate mno_id_map entries
DELETE m2.*
FROM mno_id_map m1
JOIN mno_id_map m2 ON (m1.mno_entity_guid = m2.mno_entity_guid AND m1.mno_entity_name = m2.mno_entity_name AND m1.app_entity_id = m2.app_entity_id AND m1.app_entity_name = m2.app_entity_name AND m1.db_timestamp < m2.db_timestamp);
