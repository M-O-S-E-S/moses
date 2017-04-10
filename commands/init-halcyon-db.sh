#!/bin/sh

dockerSection="mgmt:"
templateName="moses_gridserver_1"

# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}



dbConfig=`cat docker-compose.yml | grep "$dockerSection" -A 16 | tail -4`

host=`echo "$dbConfig" | grep HAL_DB_HOST | cut -d ":" -f2 | sed 's/ //g'`
database=`echo "$dbConfig" | grep HAL_DB_DATABASE | cut -d ":" -f2 | sed 's/ //g'`
user=`echo "$dbConfig" | grep HAL_DB_USER | cut -d ":" -f2 | sed 's/ //g'`
pass=`echo "$dbConfig" | grep HAL_DB_PASS | cut -d ":" -f2 | sed 's/ //g'`

echo 'initializing halcyon database'
echo 'this will erase any existing halcyon data'
echo 'press ctrl-c within 10 seconds to abort'

sleep 10

echo 'proceeding...'

template=`docker ps --all | grep $templateName | cut -d ' ' -f1`

if [ "x$template" = "x" ]; then
  echo "$templateName container does not exist.  Have you run docker-compose up -d first?"
  exit 1;
fi

template=`docker inspect moses_gridserver_1 | grep Image | head -1 | sed 's/ //g' | cut -d":" -f3 | sed 's/"//g' | sed 's/,//g'`

echo "$templateName image discovered as $template"

echo "executing initialization"

output=`docker run --rm --network="moses_default" "$template" mono hc-database.exe --init -t core -h "$host" -s "$database" -u "$user" -p "$pass" 2> /dev/null`

if contains "$output" "WAIT_TIMEOUT"; then
  echo "Complete"
  exit 0;
fi;

echo "$output"




