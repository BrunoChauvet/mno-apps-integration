#!/bin/bash

# Reset database
mysql vtiger6 -uvtiger6 -pvtiger6 < nuke_database.sql

# Run vTiger6 installation script
cd ../../vtiger6
php migrate.php

# Apply MNO patch
mysql vtiger6 -uvtiger6 -pvtiger6 < maestrano/app/db/1_add_mno_uid_field.sql
