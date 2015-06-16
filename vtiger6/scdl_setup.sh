#!/bin/bash

# Reset database
mysql vtiger6 -uvtiger6 -pvtiger6 < nuke_database.sql
mysql vtiger6 -uvtiger6 -pvtiger6 < /home/bruno/vtigercrm6_20150611.sql
mysql vtiger6 -uvtiger6 -pvtiger6 < cleanup.sql

cd ../../vtiger6

# Delete installed modules
# rm -rf modules/EventManagement
# rm -rf modules/EventTicket

# Run vTiger6 installation script
php migrate.php

# Cleanup
cd ../mno-apps-integration/vtiger6
mysql vtiger6 -uvtiger6 -pvtiger6 < post_cleanup.sql
