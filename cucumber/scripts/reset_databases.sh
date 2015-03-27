#!/bin/bash
mysql dolibarr -udolibarr -pdolibarr < ../dolibarr/reset_database.sql
mysql simpleinvoices -usimpleinvoices -psimpleinvoices < ../simpleinvoices/reset_database.sql
mysql vtiger -uvtiger -pvtiger < ../vtiger/reset_database.sql
mysql vtiger6 -uvtiger6 -pvtiger6 < ../vtiger6/reset_database.sql
mysql sugarcrm -usugarcrm -psugarcrm < ../sugarcrm/reset_database.sql
mysql limesurvey -ulimesurvey -plimesurvey < ../limesurvey/reset_database.sql
mysql orangehrm -uorangehrm -porangehrm < ../orangehrm/reset_database.sql
mysql timetrex -utimetrex -ptimetrex < ../timetrex/reset_database.sql
