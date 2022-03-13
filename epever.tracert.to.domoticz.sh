#!/bin/bash
#
# epever.tracert.to.domoticz.sh
#
# Tested on : EpEver Tracer 3210AN 30A MPPT Solar Controller
# Date      : 12-10-2020
# Version   : 00,00.00,000.1
#
# Created by ILoveIOT 2020"
#
#
####################################################################################################################################
# INFO="This script will execute the /root/scripts/epevertracer/epever.tracer.php file put the output to a file, 
# get the value's from the output file, show them on console if needed, and send them to Domoticz, this is super simple, easy too change.
# Many thanks to Toggio (https://github.com/toggio/PhpEpsolarTracer)

# For console use     : /root/scripts/epevertracer/epever.tracert.to.domoticz.sh
# For crontab use     : /root/scripts/epevertracer/epever.tracert.to.domoticz.sh >> /dev/null 2>&1
# For all the info    : php /root/scripts/epevertracer/example_cli.php

# 1. Change the serial port /root/scripts/epevertracer/epever.tracer.php line 26 ('/dev/ttyXRUSB0')
# 2. Change the Domoticz IP & Port (see below)
# 3. Add/Change the acording Domoticz IDX's (see below)
# 4. Optional : Change the working directory, where you wanna place the files
# 5. Optional : If you need more info from the controller compare epever.tracer.php vs example_cli.php
# 6. Optional : Maybe make 2 cronjobs, with no sunhours just poll once a hour, with sun every min."
####################################################################################################################################

# Working directory, place where all epever tracer file's are
WORKINGDIR="/app/epever-metrics-for-domoticz"

# Domoticz IP address
DOMOTICZIP="dz-insecure.hs.mfis.net"
DOMOTICZPORT="80"

### PV Array
## Domoticz dummy Voltage
#PVARRAYVOLTAGEIDX="286"
## Domoticz dummy 1 fase AMP
#PVARRAYCURRENTIDX="287"
## Domoticz dummy Electricity (instant and counter) (change item, utility, item, change, Choose delivery and Energy read: Computed)
#PVARRAYPOWERIDX="288"
## Domoticz dummy temp
#PVARRAYTEMPIDX="289"

### Battery
# Domoticz dummy Voltage
PVBATTERYVOLTAGEIDX="586"
PVBATTERYSOCIDX="587"
# Domoticz dummy 1 fase AMP
#BATTERYCHARGINGCURRENTIDX="291"
# Domoticz dummy Electricity (instant and counter) (change item, utility, item, change, Choose delivery and Energy read: Computed)
#BATTERYCHARGINGPOWERIDX="292"

### Consumption and Production Metrics (kWh)
# Domoticz custom sensor (Axis kWh)
#GENERATEKWHTODAYIDX="294"
# Domoticz custom sensor (Axis kWh)
#GENERATEKWHTOTALIDX="295"
# Domoticz custom sensor (Axis kWh)
#GENERATEKWHMONTHIDX="296"
# Domoticz custom sensor (Axis kWh)
#GENERATEKWHYEARIDX="297"
# Domoticz custom sensor (Axis kWh)
#CONSUMEDENERGYTODAYIDX="300"
# Domoticz custom sensor (Axis kWh)
#CONSUMEDENERGYTHISMONTHIDX="301"
# Domoticz custom sensor (Axis kWh)
#CONSUMEDENERGYTHISYEARIDX="302"
# Domoticz custom sensor (Axis kWh)
#CONSUMEDENERGYTOTALIDX="303"


### Load
# Domoticz dummy 1 fase AMP
#LOADCURRENTIDX="298"
# Domoticz dummy Electricity (instant and counter) (change item, utility, item, change, Energy read: Computed)
#LOADPOWERIDX="306"


####################################################################################################################################
####################################################################################################################################

# The txt output file from reading from the solar controller
OUTPUTFILE="$WORKINGDIR/epever.output.txt"


# Generate the txt file with controller output (https://github.com/toggio/PhpEpsolarTracer)
/usr/bin/php $WORKINGDIR/epever.tracer.php > $OUTPUTFILE


# Getting the value's from the output file, and make them readable, so delete the C/V/A/W/kWh letters
#CHARGERTEMP=`cat $OUTPUTFILE | sed -n 14p | awk '{print $4}' | sed 's/.$//' | sed 's/.$//'`
#PVARRAYVOLTAGE=`cat $OUTPUTFILE | sed -n 4p | awk '{print $5}' | sed 's/\V//g'`
#PVARRAYCURRENT=`cat $OUTPUTFILE | sed -n 5p | awk '{print $5}' | sed 's/\A//g'`
#PVARRAYPOWER=`cat $OUTPUTFILE | sed -n 6p | awk '{print $5}' | sed 's/.$//'`
#
#GENERATEKWHTODAY=`cat $OUTPUTFILE | sed -n 32p | awk '{print $5}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`
#GENERATEKWHMONTH=`cat $OUTPUTFILE | sed -n 33p | awk '{print $6}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`
#GENERATEKWHYEAR=`cat $OUTPUTFILE | sed -n 34p | awk '{print $6}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`
#GENERATEKWHTOTAL=`cat $OUTPUTFILE | sed -n 35p | awk '{print $5}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`

BATTERYVOLTAGE=`cat $OUTPUTFILE | sed -n 7p | awk '{print $4}' | sed 's/.$//'`
BATTERYSOC=`cat $OUTPUTFILE | sed -n 16p | awk '{print $4}' | sed 's/.$//'`
#BATTERYCHARGINGCURRENT=`cat $OUTPUTFILE | sed -n 8p | awk '{print $5}' | sed 's/.$//'`
#BATTERYCHARGINGPOWER=`cat $OUTPUTFILE | sed -n 9p | awk '{print $5}' | sed 's/.$//'`

#LOADCURRENT=`cat $OUTPUTFILE | sed -n 11p | awk '{print $4}' | sed 's/.$//'`
#LOADPOWER=`cat $OUTPUTFILE | sed -n 12p | awk '{print $4}' | sed 's/.$//'`

#CONSUMEDENERGYTODAY=`cat $OUTPUTFILE | sed -n 28p | awk '{print $5}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`
#CONSUMEDENERGYTHISMONTH=`cat $OUTPUTFILE | sed -n 29p | awk '{print $6}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`
#CONSUMEDENERGYTHISYEAR=`cat $OUTPUTFILE | sed -n 30p | awk '{print $6}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`
#CONSUMEDENERGYTOTAL=`cat $OUTPUTFILE | sed -n 31p | awk '{print $5}' | sed 's/.$//' | sed 's/.$//' | sed 's/.$//'`


# Display the main value's to console with clear value's
echo "$INFO"
echo ""
#echo "CHARGERTEMP             = $CHARGERTEMP °C"
#echo "PVARRAYVOLTAGE          = $PVARRAYVOLTAGE V"
#echo "PVARRAYCURRENT          = $PVARRAYCURRENT A"
#echo "PVARRAYPOWER            = $PVARRAYPOWER W"
#echo "GENERATEKWHTODAY        = $GENERATEKWHTODAY kWh"
#echo "GENERATEKWHMONTH        = $GENERATEKWHMONTH kWh"
#echo "GENERATEKWHYEAR         = $GENERATEKWHYEAR kWh"
#echo "GENERATEKWHTOTAL        = $GENERATEKWHTOTAL kWh"
echo "BATTERYVOLTAGE          = $BATTERYVOLTAGE V"
echo "BATTERYSOC              = $BATTERYSOC %"
#echo "BATTERYCHARGINGCURRENT  = $BATTERYCHARGINGCURRENT A"
#echo "BATTERYCHARGINGPOWER    = $BATTERYCHARGINGPOWER W"
#echo "LOADCURRENT             = $LOADCURRENT A"
#echo "LOADPOWER               = $LOADPOWER W"
#echo "CONSUMEDENERGYTODAY     = $CONSUMEDENERGYTODAY kWh"
#echo "CONSUMEDENERGYTHISMONTH = $CONSUMEDENERGYTHISMONTH kWh"
#echo "CONSUMEDENERGYTHISYEAR  = $CONSUMEDENERGYTHISYEAR kWh"
#echo "CONSUMEDENERGYTOTAL     = $CONSUMEDENERGYTOTAL kWh"
echo ""

# Some dummy value for Domoticz energy total
DUMMYVALUE="1"

# Send the value's to Domoticz
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$PVARRAYTEMPIDX&nvalue=0&svalue=$CHARGERTEMP" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$PVARRAYVOLTAGEIDX&nvalue=0&svalue=$PVARRAYVOLTAGE" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$PVARRAYCURRENTIDX&nvalue=0&svalue=$PVARRAYCURRENT" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$PVARRAYPOWERIDX&nvalue=0&svalue="$PVARRAYPOWER";"$DUMMYVALUE"" >> /dev/null 2>&1
curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$PVBATTERYVOLTAGEIDX&nvalue=0&svalue=$BATTERYVOLTAGE" >> /dev/null 2>&1
curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$PVBATTERYSOCIDX&nvalue=0&svalue=$BATTERYSOC" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$BATTERYCHARGINGCURRENTIDX&nvalue=0&svalue=$BATTERYCHARGINGCURRENT" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$BATTERYCHARGINGPOWERIDX&nvalue=0&svalue="$BATTERYCHARGINGPOWER";"$DUMMYVALUE"" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$GENERATEKWHTODAYIDX&nvalue=0&svalue=$GENERATEKWHTODAY" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$GENERATEKWHTOTALIDX&nvalue=0&svalue=$GENERATEKWHTOTAL" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$GENERATEKWHMONTHIDX&nvalue=0&svalue=$GENERATEKWHMONTH" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$GENERATEKWHYEARIDX&nvalue=0&svalue=$GENERATEKWHYEAR" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$LOADCURRENTIDX&nvalue=0&svalue=$LOADCURRENT" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$LOADPOWERIDX&nvalue=0&svalue="$LOADPOWER";"$DUMMYVALUE"" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$CONSUMEDENERGYTODAYIDX&nvalue=0&svalue=$CONSUMEDENERGYTODAY" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$CONSUMEDENERGYTHISMONTHIDX&nvalue=0&svalue=$CONSUMEDENERGYTHISMONTH" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$CONSUMEDENERGYTHISYEARIDX&nvalue=0&svalue=$CONSUMEDENERGYTHISYEAR" >> /dev/null 2>&1
#curl -i -s "http://$DOMOTICZIP:$DOMOTICZPORT/json.htm?type=command&param=udevice&idx=$CONSUMEDENERGYTOTALIDX&nvalue=0&svalue=$CONSUMEDENERGYTOTAL" >> /dev/null 2>&1

exit
