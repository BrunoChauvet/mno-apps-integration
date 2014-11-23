#!/bin/bash
mysql dolibarr -udolibarr -pdolibarr < ../dolibarr/reset_database.sql
mysql simpleinvoices -usimpleinvoices -psimpleinvoices < ../simpleinvoices/reset_database.sql
mysql vtiger -uvtiger -pvtiger < ../vtiger/reset_database.sql
mysql sugarcrm -usugarcrm -psugarcrm < ../sugarcrm/reset_database.sql
