cd /home/pi/envirophat

sudo python sense.py 2>/dev/null > /home/pi/envirophat/readings.txt

sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' /home/pi/envirophat/readings.txt | tee /home/pi/envirophat/readingsnolf.txt

# Create Tweet
echo "{ \"text\" : \"" | tr -d '\n' > tweet.txt
cat /home/pi/envirophat/readingsnolf.txt | tr -d '\n' >> tweet.txt
echo "\"}" >> tweet.txt

# Tweet it
sudo python3 tweeter.py
