cd /home/user/weather/pywws
curl -X GET --header 'Accept: application/json' 'https://swd.weatherflow.com/swd/rest/observations/station/<YOUR STATION>?<YOUR TOKEN>' 2>/dev/null  | jq -r '.obs[0]' > /home/dstorey/obs.txt

echo "T: " | tr -d '\n' > /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].air_temperature' | tr -d '\n' >> /home/user/weatherflow.txt

echo "c, P: " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].barometric_pressure' | tr -d '\n' >> /home/user/weatherflow.txt

echo "mb, Humid: " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].relative_humidity' | tr -d '\n' >> /home/user/weatherflow.txt

echo "%, Rain: " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].precip_accum_local_day' | tr -d '\n' >> /home/user/weatherflow.txt

echo "mm, Gust: " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].wind_gust' | tr -d '\n' >> /home/user/weatherflow.txt

echo "mph, Bright: " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].brightness' | tr -d '\n' >> /home/user/weatherflow.txt

echo "lux, UV: " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].uv' | tr -d '\n' >> /home/user/weatherflow.txt

echo ", Strikes: " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].lightning_strike_count' | tr -d '\n' >> /home/user/weatherflow.txt

echo " (" | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].lightning_strike_last_distance' | tr -d '\n' >> /home/user/weatherflow.txt

echo "km " | tr -d '\n' >> /home/user/weatherflow.txt
cat obs.txt | jq -r '.obs[0].lightning_strike_last_epoch' | { read gmt ; date -d @"$gmt" ; } | tr -d '\n' >> /home/user/weatherflow.txt
echo ")" | tr -d '\n' >> /home/user/weatherflow.txt

sudo python -m pywws.ToTwitter /home/user/weather/data/ /home/user/weatherflow.txt
