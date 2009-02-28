#!/bin/sh

# mysqlstart.sh
# servebox
#
# Created by Alex Coomans on 7/14/08.
# Copyright 2008 Alex Coomans. All rights reserved.


/Applications/servebox/services/Library/mysql/bin/mysqld_safe --user=mysql --log --log-error=/Applications/servebox/services/logs/mysql_error.log


