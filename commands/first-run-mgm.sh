#!/bin/sh

image="moses_mgmt_1"

search=`docker ps | grep "$image"`

if [ "x$search" = "x" ]; then
  echo "$image is not running.  Have you run docker-compose up -d first?"
  exit 1;
fi

echo "mgm first-run script"
echo "~~~~~~~~~~~~~~~~~~~~"
echo
echo "This script will create an administrative user"
echo "It will also create template accounts, overwriting your current template settings"
echo

echo -n "Do you with to continue (y/N):"
read cont

if [ ! "x$cont" = "xy" ]; then 
  exit 1;
fi;

echo "creating the M and F template avatars"

output=`docker exec "$image" node scripts/create-user.js Male Template - password123`
M=`echo "$output" | grep UUID | cut -d":" -f2 | sed 's/ //g'`

if [ "x$M" = "x" ]; then
  echo "Error creating Male Template: $output"
  exit 1;
fi

output=`docker exec "$image" node scripts/create-user.js Female Template - password123`
F=`echo "$output" | grep UUID | cut -d":" -f2 | sed 's/ //g'`

if [ "x$M" = "x" ]; then
  echo "Error creating Male Template: $output"
  exit 1;
fi


echo "{M: $M, F: $F}"
sed -i "s/TEMPLATES:.*/TEMPLATES: '{\"M\": \"$M\", \"F\": \"$F\"}'/g" docker-compose.yml

echo "We will now create an administrative account for you.  Please enter the following:"

echo -n "First Name:"
read fname
echo -n "Last Name:"
read lname
echo -n "email:"
read email
echo -n "password:"
read password

if [ ! "x$cont" = "xy" ]; then 
  exit 1;
fi;

echo "Creating your account"
docker exec "$image" node scripts/create-user.js "$fname" "$lname" "$email" "$password" 250

echo "Done.  You will need to run docker-compose down && docker-compose up-d to reload the mgmt environment variables for the template"