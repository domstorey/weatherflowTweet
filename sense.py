from envirophat import leds
# leds.on()
leds.off()

# reduce temperature as close too processor by 8c
fudge = 8.0

from envirophat import weather
altitude=weather.altitude(qnh=1026) # qnh=1027 1013.25
print "BMP280 ","T: {:.1f}c".format(weather.temperature()-fudge),
print " P: {:.2f}hPa".format(weather.pressure()/100) #, # unit='hPa'

from envirophat import motion
mag_values = motion.magnetometer()
mx=mag_values[0]
my=mag_values[1]
mz=mag_values[2]
h=motion.heading()
print "LSM303D", "Heading: {:.0f}deg".format(h)," Magnetometer: {:} {:} {:}".format(mx,my,mz)

from envirophat import light
rgb=light.rgb()
r=rgb[0]
g=rgb[1]
b=rgb[2]
print "TCS3472","Bright: {:.0f}lux".format(light.light())," RGB: {:},{:},{:}".format(r,g,b)
hex='%02x%02x%02x' % rgb
print "https://www.colorhexa.com/{:}".format(hex)  
