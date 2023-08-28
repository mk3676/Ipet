from PIL import Image
import io
import json
import requests
from flask import Flask, render_template, request
from ipethos.database import Database
import pandas as pd
import openai
import requests
import urllib.request
import time
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
@app.route('/admin/getlist')
def getlist():
    db_class = Database()
    memberList = db_class.executeAll(
        "select mno as '고객번호',name as '이름',"
        " address1 as '주소', address2 as '상세주소', email as '이메일',"
        " id as '아이디',"
        " createDate as '가입 날짜'"
        " from ipetmember where auth='m'")
    address = "C:\\Users\\upload\\memberList\\"
    pd.DataFrame(memberList).to_csv(address+"memberList.csv",encoding='euc-kr')
    return "";


@app.route('/makeImage', methods=['POST'])
def index():
    openai.api_key = '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'
    key1 = request.form.get('key1')
    key2 = request.form.get('key2')
    url = "https://openapi.naver.com/v1/papago/n2mt"
    headers = {
        'Content-Type': 'application/json',
        'X-Naver-Client-Id': "gLLOp_b8UUUr71Uiwv3F"
        ,
        'X-Naver-Client-Secret': "THw0sjSkih"
    }
    data = {'source': 'ko', 'target': 'en', 'text': key1}  # source는 한글 target은 영어로 지정
    response = requests.post(url, json.dumps(data), headers=headers)
    print(response.json())
    translated_data=  response.json()['message']['result']['translatedText']
    print(translated_data)
    response = openai.Image.create(
        prompt=translated_data,
        n=1,
        size="256x256"
    )
    image_url = response['data'][0]['url']
    img_dest="C:\\Users\\upload\\makeImage\\"
    start = time.time()
    url = image_url
    urllib.request.urlretrieve(image_url,img_dest+key2+".png")

    return response['data'][0]['url']

if __name__ =="__main__":
    app.run(port=5500)