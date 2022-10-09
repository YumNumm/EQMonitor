import requests
import json
import os
import datetime


DMDATA_KEY = os.getenv("DMDATA_KEY")
DMDATA_ORIGIN = os.getenv("DMDATA_ORIGIN")

def downloadParam():
    url = f"https://api.dmdata.jp/v2/parameter/earthquake/station?key={DMDATA_KEY}"
    res = requests.get(
        url,
        headers={"Origin": DMDATA_ORIGIN},
    )
    with open("station.json", "wb") as file:
        for chunk in res.iter_content(chunk_size=1024):
            file.write(chunk)


def getArv(lat, lon):
    res = requests.get(
        f"https://www.j-shis.bosai.go.jp/map/api/sstrct/V2/meshinfo.geojson?position={lon},{lat}&epsg=4612"
    )
    j = res.json()
    arv = j["features"][0]["properties"]["ARV"]
    return arv


downloadParam()

with open(
    "./station.json",
    encoding="utf-8",
) as f:
    os.makedirs("./public", exist_ok=True)
    with open(
        "./public/arv.json",
        "w",
        newline="",
        encoding="utf-8",
    ) as w:
        j = json.loads(f.read())
        items = []
        c = 0
        for i in j["items"]:
            arv = getArv(i["latitude"], i["longitude"])
            c+=1
            name = i["name"]
            print(f"{c}: {name} {arv}")
            items.append(
                {
                    "code": i["code"],
                    "arv": arv,
                }
            )
        dt = datetime.datetime.today()
        output = {
            "responseId": j["responseId"],
            "responseTime": j["responseTime"],
            "mergedAt": dt.isoformat(),
            "status": j["status"],
            "changeTime": j["changeTime"],
            "version": j["version"],
            "items": items,
        }
        json.dump(output, w)
