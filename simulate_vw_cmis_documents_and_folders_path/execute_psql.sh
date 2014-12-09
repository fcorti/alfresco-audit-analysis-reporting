#!/bin/sh
export ROOT_USER=postgres
export AAAR_TESTDB=aaar_testdb
export AAAR_TESTUSER=aaar_testuser
export AAAR_TESTUSER_PASSWORD=password

sudo su -c "psql -c \"DROP DATABASE $AAAR_TESTDB;\"" $ROOT_USER
sudo su -c "psql -c \"DROP USER $AAAR_TESTUSER;\"" $ROOT_USER 
sudo su -c "psql -c \"CREATE DATABASE $AAAR_TESTDB;\"" $ROOT_USER
sudo su -c "psql -c \"CREATE USER $AAAR_TESTUSER PASSWORD '$AAAR_TESTUSER_PASSWORD';\"" $ROOT_USER
sudo su -c "psql -c \"GRANT ALL ON DATABASE $AAAR_TESTDB TO $AAAR_TESTUSER;\"" $ROOT_USER
PGPASSWORD=$AAAR_TESTUSER_PASSWORD psql -U $AAAR_TESTUSER -f table_psql.sql $AAAR_TESTDB
PGPASSWORD=$AAAR_TESTUSER_PASSWORD psql -U $AAAR_TESTUSER -f data_psql.sql $AAAR_TESTDB
PGPASSWORD=$AAAR_TESTUSER_PASSWORD psql -U $AAAR_TESTUSER -f test_query_success_psql.sql $AAAR_TESTDB > test_query_success_psql.out
