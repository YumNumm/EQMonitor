import csv
import requests
import json
from collections import OrderedDict
import pprint


def getArv(lat,lon):
    res = requests.get(
        f"https://www.j-shis.bosai.go.jp/map/api/sstrct/V2/meshinfo.geojson?position={lon},{lat}&epsg=4612"
    )
    j = res.json()
    arv = j["features"][0]["properties"]["ARV"]
    return arv


with open(
    "C:/Users/onory/dev/EQMonitor/assets/station.json",
    encoding="utf-8",
) as f:
    with open(
        "C:/Users/onory/dev/EQMonitor/assets/station2.json",
        "w",
        newline="",
        encoding="utf-8",
    ) as w:
        count = 0
        db = json.loads(f.read())
        for item in db['items']:
          count += 1
          arv = getArv(item['latitude'], item['longitude'])
          print([count, arv])
          item['arv'] = arv
        json.dump(db, w,indent=2, ensure_ascii=False)


#         reader = csv.reader(f)
#         writer = csv.writer(w)
#         for row in reader:
#             count += 1
#             arv = getArv(row[6], row[5])
#             print([count, arv])
#             writer.writerow(
#                 ([row[1], row[4], row[3], row[5], row[6], row[7], row[8], arv])
#             )
