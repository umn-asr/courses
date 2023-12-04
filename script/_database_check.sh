#!/bin/bash

sqlplus -s /nolog << EOF > /dev/null 2>&1
WHENEVER SQLERROR EXIT SQL.SQLCODE
CONNECT sys/Oradoc_db1@//database:1521/ORCLCDB.localdomain as sysdba
EOF
