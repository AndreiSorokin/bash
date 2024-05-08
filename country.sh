#!/bin/bash

if [ $# -eq 0 ]; then
   echo "Usage: $0 <CountryName1> [CountryName2] ..."
   exit 1
fi

for country in "$@"; do
   response=$(curl -k "https://restcountries.com/v3.1/name/$country")
   if [ -z "$response" ]; then
      echo "No information found for $country."
      continue
   fi

   country_name=$(echo "$response" | grep -o '"common":"[^"]*' | cut -d'"' -f4 | head -1)
   population=$(echo "$response" | grep -o '"population":[0-9]*' | cut -d':' -f2 | head -1)
   capital=$(echo "$response" | grep -o '"capital":\s*\["[^"]*' | cut -d'"' -f4)
   languages=$(echo "$response" | grep -o '"languages":{[^}]*' | cut -d'{' -f2 | tr ',' '\n' | cut -d':' -f2 | tr -d '"' | tr '\n' ', ' | sed 's/, $//')

   echo "Country: $country_name"
   echo "Population: $population"
   echo "Capital: $capital"
   echo "Languages: $languages"
   echo "--------------------------------"
done