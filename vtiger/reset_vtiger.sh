#!/bin/bash

# Reset vTiger installation
mysql vtiger -uvtiger -pvtiger -e 'drop database vtiger; create database vtiger;'
chmod 777 config.inc.php tabdata.php parent_tabdata.php
