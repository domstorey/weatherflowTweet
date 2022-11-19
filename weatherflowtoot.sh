cd /home/pi/weather

curl -X GET --header 'Accept: application/json' 'https://swd.weatherflow.com/swd/rest/observations/station/33047?token=NOTMYTOKEN' 2>/dev/null > /home/pi/weather/obs.txt

echo "T: " | tr -d '\n' > /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].air_temperature' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "c" >> /home/pi/weather/weatherflow.txt

echo "P: " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].sea_level_pressure' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "hPa " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].pressure_trend' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "" >> /home/pi/weather/weatherflow.txt

echo "Humid: " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].relative_humidity' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "%" >> /home/pi/weather/weatherflow.txt

echo "Rain: " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].precip_accum_local_day' | tr -d '\n' | xargs printf "%.2f" >> /home/pi/weather/weatherflow.txt
echo "mm" >> /home/pi/weather/weatherflow.txt

echo "Gust: " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].wind_gust' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "mph" >> /home/pi/weather/weatherflow.txt

echo "Bright: " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].brightness' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "lux" >> /home/pi/weather/weatherflow.txt

echo "UV: " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].uv' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "" >> /home/pi/weather/weatherflow.txt

echo "Strikes: " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].lightning_strike_count' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo " (" | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].lightning_strike_last_distance' | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo "km " | tr -d '\n' >> /home/pi/weather/weatherflow.txt
cat /home/pi/weather/obs.txt | jq -r '.obs[0].lightning_strike_last_epoch' | { read gmt ; date -d @"$gmt" ; } | tr -d '\n' >> /home/pi/weather/weatherflow.txt
echo ")" | tr -d '\n' >> /home/pi/weather/weatherflow.txt

sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' /home/pi/weather/weatherflow.txt | tee /home/pi/weather/weatherflownolf.txt

# Create Tweet
#echo "{ \"text\" : \"" | tr -d '\n' > tweet.txt
#cat /home/pi/weather/weatherflownolf.txt >> tweet.txt
#echo "\"}" >> tweet.txt

# Tweet it
# sudo python3 tweeter.py

# Create toot
echo "curl --header 'Authorization: Bearer NOTMYBEARERTOKEN!!!' --header 'Content-Type: application/json' -X POST -d '{ \"status\" : \"" | tr -d '\n' > toot.sh
cat /home/pi/weather/weatherflownolf.txt >> toot.sh
echo "\"}' https://wxcloud.social/api/v1/statuses" >> toot.sh

chmod 777 toot.sh
./toot.sh
