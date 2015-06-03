#!/bin/bash

# Reset database
mysql vtiger6 -uvtiger6 -pvtiger6 < nuke_database.sql

cd ../../vtiger6

# Delete installed modules
rm -rf modules/EventManagement
rm -rf modules/EventTicket

# Run vTiger6 installation script
php install.php

# Apply MNO patch
mysql vtiger6 -uvtiger6 -pvtiger6 < maestrano/app/db/1_add_mno_uid_field.sql
