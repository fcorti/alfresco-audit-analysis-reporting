#!/bin/sh
export MYSQL_HOST=localhost
export ROOT_USER=root
export ROOT_PASSWORD=password
export AAAR_TESTDB=aaar_testdb
export AAAR_TESTUSER=aaar_testuser
export AAAR_TESTUSER_PASSWORD=password

mysqladmin -f -h $MYSQL_HOST -u $ROOT_USER -p$ROOT_PASSWORD drop $AAAR_TESTDB
mysqladmin -h $MYSQL_HOST -u $ROOT_USER -p$ROOT_PASSWORD create $AAAR_TESTDB
mysql -h $MYSQL_HOST -u $ROOT_USER -p$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $AAAR_TESTDB.* TO '$AAAR_TESTUSER'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION"
mysql -h $MYSQL_HOST -u $ROOT_USER -p$ROOT_PASSWORD -e "FLUSH PRIVILEGES"

mysql -h $MYSQL_HOST -u $AAAR_TESTUSER -p$AAAR_TESTUSER_PASSWORD -D $AAAR_TESTDB < table_mysql.sql
mysql -h $MYSQL_HOST -u $AAAR_TESTUSER -p$AAAR_TESTUSER_PASSWORD -D $AAAR_TESTDB < data_mysql.sql
mysql -h $MYSQL_HOST -u $AAAR_TESTUSER -p$AAAR_TESTUSER_PASSWORD -D $AAAR_TESTDB < test_query_error_mysql.sql > test_query_error_mysql.out
mysql -h $MYSQL_HOST -u $AAAR_TESTUSER -p$AAAR_TESTUSER_PASSWORD -D $AAAR_TESTDB < test_query_success_mysql.sql > test_query_success_mysql.out
