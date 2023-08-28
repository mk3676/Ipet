from PIL import Image
import io
import json
import requests
from flask import Flask,render_template


app=Flask(__name__)
def makeMap(address):
    api_key="de5a2b68de946e7a3034e5b3462c1eb6"
    def getLatLng(addr):
        url = 'https://dapi.kakao.com/v2/local/search/address.json?query=' + addr
        headers = {"Authorization": "KakaoAK 073a393656181c6073880062d3507191"}
        result = json.loads(str(requests.get(url, headers=headers).text))
        match_first = result['documents'][0]['address']
        return float(match_first['y']), float(match_first['x'])

    # NCP 콘솔에서 복사한 클라이언트ID와 클라이언트Secret 값

    # 좌표 (경도, 위도)
    endpoint = "https://naveropenapi.apigw.ntruss.com/map-static/v2/raster"
    headers = {
        "X-NCP-APIGW-API-KEY-ID": "vkzkfo3o68",
        "X-NCP-APIGW-API-KEY": "r3mI9u0aU1h59oCyn4NqNeVlt7qI1zm7DocnyIAi",
    }
    # 중심 좌표

    lat, lon = getLatLng(str(address))
    _center = f"{lon},{lat}"
    # 줌 레벨 - 0 ~ 20
    _level = 16
    # 가로 세로 크기 (픽셀)
    _w, _h = 500, 300
    # 지도 유형 - basic, traffic, satellite, satellite_base, terrain
    _maptype = "terrain"
    # 반환 이미지 형식 - jpg, jpeg, png8, png
    _format = "png"
    # 고해상도 디스펠레이 지원을 위한 옵션 - 1, 2
    _scale = 1
    # 마커
    _markers = f"""type:d|size:mid|pos:{lon} {lat}|color:red"""
    # 라벨 언어 설정 - ko, en, ja, zh
    _lang = "ko"
    # 대중교통 정보 노출 - Boolean
    _public_transit = True
    # 서비스에서 사용할 데이터 버전 파라미터 전달 CDN 캐시 무효화
    _dataversion = ""

    # URL
    url = f"{endpoint}?center={_center}&level={_level}&w={_w}&h={_h}&maptype={_maptype}&format={_format}&scale={_scale}&markers={_markers}&lang={_lang}&public_transit={_public_transit}&dataversion={_dataversion}"
    res = requests.get(url, headers=headers)

    image_data = io.BytesIO(res.content)
    image = Image.open(image_data)
    image.save("./static/map.png", 'png')
    return ""

@app.route("/hospital/map/<address>")
def getMap(address):
    print(address)
    makeMap(address)
    return render_template("map.html")

if __name__ =="__main__":
    app.run(port=5500)