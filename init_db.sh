#!/usr/bin/env bash


docker compose up -d  

sleep 5

function run_psql() {
  local sql_input="$1"
  PGPASSWORD=secret psql -U myuser -h localhost mydatabase <<EOF
$sql_input
EOF
}

run_psql "drop table vector_store "
run_psql "drop table event_publication "
run_psql "drop table dog "
run_psql "`cat dogs.sql`"
run_psql "select id, name from dog" 