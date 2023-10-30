#!/bin/bash

#	Last updated - 6/13/22 - JDK

user="USERNAME_HERE"
password="PASSWORD_HERE"
url="https://URL_HERE.jamfcloud.com"
testID="ID_HERE"

# Get username and password encoded in base64 format and stored as a variable in a script:
encodedCredentials=$( printf "$user:$password" | /usr/bin/iconv -t ISO-8859-1 | /usr/bin/base64 -i - )

# Use encoded username and password to request a token with an API call and store the output as a variable in a script:
token=$(/usr/bin/curl $url/uapi/auth/tokens -s -X POST -H "Authorization: Basic $encodedCredentials" | grep token | awk '{print $3}' | tr -d ',"')

echo $token

echo -e "\n-----------------------------------------------------------------------------------------------------------------------"

now=$(date +"%c")

echo "Date of run: $now"


#######TEST TO MAKE SURE COMMAND WORKS#############
###Needs a mobile device ID with at least one failed command
/usr/bin/curl -ks -H "content-type: text/xml" -H "Authorization: Bearer $token" $url/JSSResource/commandflush/mobiledevices/id/$testID/status/Failed -X DELETE



######Uncomment these lines once the test command is confirmed as working
#DeviceID=$(/usr/bin/curl -ks -H "Accept: application/xml" -H "Authorization: Bearer $token" $url/JSSResource/mobiledevices -X GET | xmllint --format -| awk -F '[<>]' '/\<id\>/{print $3}')

#for i in $DeviceID
	
#do
		
#		echo -e "\nRemoving failed MDM commands on device id: $i"
		
		
#		/usr/bin/curl -ks -H "content-type: text/xml" -H "Authorization: Bearer $token" $url/JSSResource/commandflush/mobiledevices/id/$i/status/Failed -X DELETE
		
		
#		result="Removed Failed MDM Commands on device id: $i"

	
#done




