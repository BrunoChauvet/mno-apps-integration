-- Disable deprecated handlers
update vtiger_eventhandlers set is_active = 0 where handler_class IN ('SQLReportsHandler', 'VTFieldFormulasEventHandler');
 
-- Replace the normal coma with a different ASCII code coma
UPDATE vtiger_industry SET industry = REPLACE(industry, ',', '‚');

-- Delete duplicated fields
DELETE v2
FROM vtiger_field v1
JOIN vtiger_field v2 ON (v1.tabid = v2.tabid and v1.columnname = v2.columnname and v1.tablename = v2.tablename and v1.fieldname = v2.fieldname and v1.fieldid < v2.fieldid);

-- Disable vTiger 5 events handlers
update vtiger_eventhandlers set is_active = 0 where handler_class IN ('SQLReportsHandler', 'VTFieldFormulasEventHandler');

-- Delete duplicated events handlers
DELETE v2
FROM vtiger_eventhandlers v1
JOIN vtiger_eventhandlers v2 ON (v1.event_name = v2.event_name and v1.handler_path = v2.handler_path and v1.handler_class = v2.handler_class and v1.cond = v2.cond and v1.eventhandler_id < v2.eventhandler_id);
