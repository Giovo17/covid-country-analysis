import pandas as pd
from geopy.geocoders import Nominatim


df = pd.read_csv("covid-country-analysis/country_wise_latest.csv")
Country_latitude = []
Country_longitude = []
WHOregion_latitude = []
WHOregion_longitude = []

# calling the Nominatim tool
loc = Nominatim(user_agent="GetLoc")

for index, row in df.iterrows():
    print(row[0])
    getLoc = loc.geocode(row[0])
    Country_latitude.append(getLoc.latitude)
    Country_longitude.append(getLoc.longitude)



df["Country_latitude"] = Country_latitude
df["Country_longitude"] = Country_longitude


df.to_csv("covid-country-analysis/country_wise_latest_coord.csv")
