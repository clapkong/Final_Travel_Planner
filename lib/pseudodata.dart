Map<String, dynamic> dbjson = {
  "user_search":[
    {
      "search_id": 1,
      "command": "6인 가족과 함께 서울로 가족 여행을 가려고 해. 어린 아이와 노인이 있으니 너무 힘들지 않은 여행이었으면 좋겠어.",
      "departure": "2024-12-21T00:00:00", 
      "arrival": "2024-12-23T00:00:00",
      "country": "Korea",
      "state": "Seoul",
      "city": "Seodaemun-gu",
      "numPeople": 1,
      "budget": 20.0,
      "accommodation": 0,
      "travelStyle": [false, true, false, true, false, false]
    }
  ],
  "travel_plans": [
    {
      "id": 1,
      "search_id": 1,
      "title": "자연과 트레킹",
      "img1": "assets/images/travel_1.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "신라",
      "keyword": "자연적",
      "price": 0.0,
      "summary": "사르바 항구 산책, 미라노 궁 투어, 라펠라 숲 트레킹"
    },
    {
      "id": 2,
      "search_id": 1,
      "title": "호수와 평온함",
      "img1": "assets/images/travel_2.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "메리어트",
      "keyword": "평온함",
      "price": 10.0,
      "summary": "아르보 바자 탐방, 실비아 호수 유람, 에덴 교회 방문"
    },
    {
      "id": 3,
      "search_id": 1,
      "title": "예술과 정원",
      "img1": "assets/images/travel_3.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "조선",
      "keyword": "예술적",
      "price": 40.0,
      "summary": "나리아 미술관, 로미타 정원 산책, 라빈다 성 투어"
    },
    {
      "id": 4,
      "search_id": 1,
      "title": "해변과 여유",
      "img1": "assets/images/travel_4.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "하얏트",
      "keyword": "여유로움",
      "price": 30.0,
      "summary": "이솔리 해변 수영, 루체르 전망대, 파르니 마을 체험"
    },
    {
      "id": 5,
      "search_id": 1,
      "title": "시장과 오솔길",
      "img1": "assets/images/travel_5.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "쉐라톤",
      "keyword": "향토적",
      "price": 15.0,
      "summary": "라코나 시장 구경, 플로렌 언덕 트레킹, 바르미 오솔길 산책"
    },
    {
      "id": 6,
      "search_id": 1,
      "title": "성과 정원",
      "img1": "assets/images/travel_6.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "콘래드",
      "keyword": "고풍적",
      "price": 10.0,
      "summary": "페르노 성 방문, 사피르 정원 산책, 로살리 박물관"
    },
    {
      "id": 7,
      "search_id": 1,
      "title": "예술 여행",
      "img1": "assets/images/travel_7.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "한화",
      "keyword": "역사적",
      "price": 20.0,
      "summary": "엘토아 해양 박물관, 나리아 성벽 투어, 세라노 거리 예술"
    },
    {
      "id": 8,
      "search_id": 2,
      "title": "자연과 트레킹",
      "img1": "assets/images/travel_7.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "프린스",
      "keyword": "일상적",
      "price": 20.0,
      "summary": "엘토아 해양 박물관, 나리아 성벽 투어, 세라노 거리 예술"
    }
  ], 
  "travel_itinery":{
    "1": {
      "Day1":[
        {
            "index": 1,
            "time": "10:00 - 11:30",
            "title": "호텔 체크인",
            "location": "서울 신라 호텔",
            "coordinate": "37.5503, 126.9908"
        },
        {
            "index": 2,
            "time": "11:30 - 12:30",
            "title": "점심",
            "location": "서울, 종로구 483",
            "coordinate": "37.5503, 126.9908",
            "subwayInfo": "4호선, 동대문역 4번 출구",
            "cost": 40000
        },
        {
            "index": 3,
            "time": "13:00 - 14:00",
            "title": "박물관 방문",
            "location": "국립중앙박물관",
            "coordinate": "37.5231, 126.9802"
        },
        {
            "index": 4,
            "time": "15:00 - 16:00",
            "title": "커피 한 잔",
            "location": "카페 베네, 서울",
            "coordinate": "37.5482, 127.0077",
            "cost": 10000
        },
        {
            "index": 5,
            "time": "16:30 - 17:30",
            "title": "공원 산책",
            "location": "남산공원, 서울",
            "coordinate": "37.5514, 126.9882"
        },
        {
            "index": 6,
            "time": "18:00 - 19:00",
            "title": "저녁 식사",
            "location": "명동교자, 서울",
            "coordinate": "37.5600, 126.9862",
            "subwayInfo": "4호선, 명동역",
            "cost": 50000
        },
        {
            "index": 7,
            "time": "19:30 - 20:00",
            "title": "거리 쇼핑",
            "location": "명동 쇼핑 거리",
            "coordinate": "37.5610, 126.9858"
        },
        {
            "index": 8,
            "time": "20:30 - 21:30",
            "title": "야경 감상",
            "location": "N서울타워",
            "coordinate": "37.5512, 126.9880",
            "cost": 15000
        }
      ],
      "Day2": [
        {
            "index": 1,
            "time": "09:00 - 09:30",
            "title": "아침 식사",
            "location": "호텔 레스토랑",
            "coordinate": "37.5503, 126.9908"
        },
        {
            "index": 2,
            "time": "09:45 - 10:45",
            "title": "사원 방문",
            "location": "조계사",
            "coordinate": "37.5741, 126.9818"
        },
        {
            "index": 3,
            "time": "11:00 - 12:00",
            "title": "경복궁 투어",
            "location": "경복궁, 서울",
            "coordinate": "37.5796, 126.9770",
            "cost": 3000
        },
        {
            "index": 4,
            "time": "12:30 - 13:30",
            "title": "북촌 점심 식사",
            "location": "북촌 한옥마을",
            "coordinate": "37.5825, 126.9857",
            "subwayInfo": "3호선, 안국역",
            "cost": 35000
        },
        {
            "index": 5,
            "time": "14:00 - 15:00",
            "title": "북촌 한옥마을 방문",
            "location": "북촌 한옥마을",
            "coordinate": "37.5825, 126.9857"
        },
        {
            "index": 6,
            "time": "15:30 - 16:00",
            "title": "차 시음",
            "location": "인사동 찻집",
            "coordinate": "37.5712, 126.9860",
            "cost": 12000
        },
        {
            "index": 7,
            "time": "16:30 - 17:00",
            "title": "인사동 탐방",
            "location": "인사동 거리",
            "coordinate": "37.5712, 126.9860"
        },
        {
            "index": 8,
            "time": "17:30 - 18:30",
            "title": "창덕궁 방문",
            "location": "창덕궁, 서울",
            "coordinate": "37.5823, 126.9910",
            "cost": 8000
        },
        {
            "index": 9,
            "time": "19:00 - 20:30",
            "title": "한식 BBQ 저녁",
            "location": "마포구, 서울",
            "coordinate": "37.5565, 126.9245",
            "cost": 70000
        },
        {
            "index": 10,
            "time": "21:00 - 22:00",
            "title": "한강 유람선 투어",
            "location": "여의도 한강공원",
            "coordinate": "37.5292, 126.9348",
            "cost": 20000
        }
      ],
      "Day3":[
        {
            "index": 1,
            "time": "10:00 - 11:30",
            "title": "호텔 체크아웃",
            "location": "신라 호텔",
            "coordinate": "37.5503, 126.9908"
        },
        {
            "index": 2,
            "time": "11:30 - 12:30",
            "title": "점심",
            "location": "서울, 종로구 483",
            "subwayInfo": "4호선, 동대문역 4번 출구",
            "cost": 40000,
            "coordinate": "37.5741, 126.9818"
        },
        {
            "index": 3,
            "time": "13:00 - 14:00",
            "title": "박물관 방문",
            "location": "국립중앙박물관",
            "coordinate": "37.5231, 126.9802"
        },
        {
            "index": 4,
            "time": "15:00 - 16:00",
            "title": "커피 한 잔",
            "location": "카페 베네, 서울",
            "cost": 10000,
            "coordinate": "37.5482, 127.0077"
        },
        {
            "index": 5,
            "time": "16:30 - 17:30",
            "title": "공원 산책",
            "location": "남산공원, 서울",
            "coordinate": "37.5514, 126.9882"
        },
        {
            "index": 6,
            "time": "18:00 - 19:00",
            "title": "저녁 식사",
            "location": "명동교자, 서울",
            "subwayInfo": "4호선, 명동역",
            "cost": 50000,
            "coordinate": "37.5600, 126.9862"
        }
      ]
    },
    "8": {
      "Day1": [
        {
          "index": 1,
          "time": "10:00 - 11:30",
          "title": "호텔 체크인",
          "location": "도쿄 신주쿠 프린스 호텔",
          "coordinate": "35.6938, 139.7034"
        },
        {
          "index": 2,
          "time": "11:30 - 12:30",
          "title": "점심",
          "location": "이치란 라멘 신주쿠점",
          "coordinate": "35.6937, 139.7020",
          "cost": 15000
        },
        {
          "index": 3,
          "time": "13:00 - 14:30",
          "title": "메이지 신궁 방문",
          "location": "메이지 신궁",
          "coordinate": "35.6764, 139.6993"
        },
        {
          "index": 4,
          "time": "15:00 - 16:30",
          "title": "하라주쿠 탐방",
          "location": "하라주쿠 거리",
          "coordinate": "35.6702, 139.7031"
        },
        {
          "index": 5,
          "time": "17:00 - 18:30",
          "title": "저녁 식사",
          "location": "오모테산도 우동 전문점",
          "coordinate": "35.6646, 139.7106",
          "cost": 25000
        },
        {
          "index": 6,
          "time": "19:00 - 20:30",
          "title": "도쿄 타워 야경",
          "location": "도쿄 타워",
          "coordinate": "35.6586, 139.7454",
          "cost": 12000
        }
      ],
      "Day2": [
        {
          "index": 1,
          "time": "09:00 - 10:00",
          "title": "아침 식사",
          "location": "호텔 조식 레스토랑",
          "coordinate": "35.6938, 139.7034"
        },
        {
          "index": 2,
          "time": "10:30 - 12:00",
          "title": "도쿄 스카이트리 방문",
          "location": "도쿄 스카이트리",
          "coordinate": "35.7101, 139.8107",
          "cost": 20000
        },
        {
          "index": 3,
          "time": "12:30 - 13:30",
          "title": "점심",
          "location": "스미다강 근처 스시집",
          "coordinate": "35.7103, 139.8105",
          "cost": 30000
        },
        {
          "index": 4,
          "time": "14:00 - 15:30",
          "title": "아사쿠사 센소지 방문",
          "location": "센소지",
          "coordinate": "35.7148, 139.7967"
        },
        {
          "index": 5,
          "time": "16:00 - 17:30",
          "title": "도쿄 이케부쿠로 산책",
          "location": "이케부쿠로 거리",
          "coordinate": "35.7298, 139.7111"
        },
        {
          "index": 6,
          "time": "18:00 - 19:30",
          "title": "저녁 식사",
          "location": "이케부쿠로 라멘 맛집",
          "coordinate": "35.7289, 139.7108",
          "cost": 15000
        }
      ],
      "Day3": [
        {
          "index": 1,
          "time": "09:00 - 10:00",
          "title": "호텔 체크아웃",
          "location": "도쿄 신주쿠 프린스 호텔",
          "coordinate": "35.6938, 139.7034"
        },
        {
          "index": 2,
          "time": "10:30 - 12:00",
          "title": "긴자 거리 탐방",
          "location": "긴자 쇼핑 거리",
          "coordinate": "35.6717, 139.7640"
        },
        {
          "index": 3,
          "time": "12:30 - 13:30",
          "title": "점심",
          "location": "긴자 스테이크 전문점",
          "coordinate": "35.6709, 139.7645",
          "cost": 50000
        },
        {
          "index": 4,
          "time": "14:00 - 15:30",
          "title": "우에노 공원 산책",
          "location": "우에노 공원",
          "coordinate": "35.7142, 139.7745"
        },
        {
          "index": 5,
          "time": "16:00 - 17:30",
          "title": "아키하바라 쇼핑",
          "location": "아키하바라 거리",
          "coordinate": "35.6986, 139.7730"
        }
      ]
    }    
  }
};
/*
Map<String, List<Map<String, dynamic>>> pseudoItinerary = {
  "Day1":[
    {
        "index": 1,
        "time": "10:00 - 11:30",
        "title": "호텔 체크인",
        "location": "서울 신라 호텔",
        "coordinate": "37.5503, 126.9908"
    },
    {
        "index": 2,
        "time": "11:30 - 12:30",
        "title": "점심",
        "location": "서울, 종로구 483",
        "coordinate": "37.5503, 126.9908",
        "subwayInfo": "4호선, 동대문역 4번 출구",
        "cost": 40000
    },
    {
        "index": 3,
        "time": "13:00 - 14:00",
        "title": "박물관 방문",
        "location": "국립중앙박물관",
        "coordinate": "37.5231, 126.9802"
    },
    {
        "index": 4,
        "time": "15:00 - 16:00",
        "title": "커피 한 잔",
        "location": "카페 베네, 서울",
        "coordinate": "37.5482, 127.0077",
        "cost": 10000
    },
    {
        "index": 5,
        "time": "16:30 - 17:30",
        "title": "공원 산책",
        "location": "남산공원, 서울",
        "coordinate": "37.5514, 126.9882"
    },
    {
        "index": 6,
        "time": "18:00 - 19:00",
        "title": "저녁 식사",
        "location": "명동교자, 서울",
        "coordinate": "37.5600, 126.9862",
        "subwayInfo": "4호선, 명동역",
        "cost": 50000
    },
    {
        "index": 7,
        "time": "19:30 - 20:00",
        "title": "거리 쇼핑",
        "location": "명동 쇼핑 거리",
        "coordinate": "37.5610, 126.9858"
    },
    {
        "index": 8,
        "time": "20:30 - 21:30",
        "title": "야경 감상",
        "location": "N서울타워",
        "coordinate": "37.5512, 126.9880",
        "cost": 15000
    }
  ],
  "Day2": [
    {
        "index": 1,
        "time": "09:00 - 09:30",
        "title": "아침 식사",
        "location": "호텔 레스토랑",
        "coordinate": "37.5503, 126.9908"
    },
    {
        "index": 2,
        "time": "09:45 - 10:45",
        "title": "사원 방문",
        "location": "조계사",
        "coordinate": "37.5741, 126.9818"
    },
    {
        "index": 3,
        "time": "11:00 - 12:00",
        "title": "경복궁 투어",
        "location": "경복궁, 서울",
        "coordinate": "37.5796, 126.9770",
        "cost": 3000
    },
    {
        "index": 4,
        "time": "12:30 - 13:30",
        "title": "북촌 점심 식사",
        "location": "북촌 한옥마을",
        "coordinate": "37.5825, 126.9857",
        "subwayInfo": "3호선, 안국역",
        "cost": 35000
    },
    {
        "index": 5,
        "time": "14:00 - 15:00",
        "title": "북촌 한옥마을 방문",
        "location": "북촌 한옥마을",
        "coordinate": "37.5825, 126.9857"
    },
    {
        "index": 6,
        "time": "15:30 - 16:00",
        "title": "차 시음",
        "location": "인사동 찻집",
        "coordinate": "37.5712, 126.9860",
        "cost": 12000
    },
    {
        "index": 7,
        "time": "16:30 - 17:00",
        "title": "인사동 탐방",
        "location": "인사동 거리",
        "coordinate": "37.5712, 126.9860"
    },
    {
        "index": 8,
        "time": "17:30 - 18:30",
        "title": "창덕궁 방문",
        "location": "창덕궁, 서울",
        "coordinate": "37.5823, 126.9910",
        "cost": 8000
    },
    {
        "index": 9,
        "time": "19:00 - 20:30",
        "title": "한식 BBQ 저녁",
        "location": "마포구, 서울",
        "coordinate": "37.5565, 126.9245",
        "cost": 70000
    },
    {
        "index": 10,
        "time": "21:00 - 22:00",
        "title": "한강 유람선 투어",
        "location": "여의도 한강공원",
        "coordinate": "37.5292, 126.9348",
        "cost": 20000
    }
  ],
  "Day3":[
    {
        "index": 1,
        "time": "10:00 - 11:30",
        "title": "호텔 체크아웃",
        "location": "신라 호텔",
        "coordinate": "37.5503, 126.9908"
    },
    {
        "index": 2,
        "time": "11:30 - 12:30",
        "title": "점심",
        "location": "서울, 종로구 483",
        "subwayInfo": "4호선, 동대문역 4번 출구",
        "cost": 40000,
        "coordinate": "37.5741, 126.9818"
    },
    {
        "index": 3,
        "time": "13:00 - 14:00",
        "title": "박물관 방문",
        "location": "국립중앙박물관",
        "coordinate": "37.5231, 126.9802"
    },
    {
        "index": 4,
        "time": "15:00 - 16:00",
        "title": "커피 한 잔",
        "location": "카페 베네, 서울",
        "cost": 10000,
        "coordinate": "37.5482, 127.0077"
    },
    {
        "index": 5,
        "time": "16:30 - 17:30",
        "title": "공원 산책",
        "location": "남산공원, 서울",
        "coordinate": "37.5514, 126.9882"
    },
    {
        "index": 6,
        "time": "18:00 - 19:00",
        "title": "저녁 식사",
        "location": "명동교자, 서울",
        "subwayInfo": "4호선, 명동역",
        "cost": 50000,
        "coordinate": "37.5600, 126.9862"
    }
  ]
};*/
/*
//ChatGPT로 생성한 가상 관광지
final List<Map<String, dynamic>> pseudoTravelPlan = [{
      "id": 1,
      "search_id": 1,
      "title": "자연과 트레킹",
      "img1": "assets/images/travel_1.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "신라",
      "keyword": "자연적",
      "price": 0.0,
      "summary": "사르바 항구 산책, 미라노 궁 투어, 라펠라 숲 트레킹"
    },
    {
      "id": 2,
      "search_id": 1,
      "title": "호수와 평온함",
      "img1": "assets/images/travel_2.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "메리어트",
      "keyword": "평온함",
      "price": 10.0,
      "summary": "아르보 바자 탐방, 실비아 호수 유람, 에덴 교회 방문"
    },
    {
      "id": 3,
      "search_id": 1,
      "title": "예술과 정원",
      "img1": "assets/images/travel_3.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "조선",
      "keyword": "예술적",
      "price": 40.0,
      "summary": "나리아 미술관, 로미타 정원 산책, 라빈다 성 투어"
    },
    {
      "id": 4,
      "search_id": 1,
      "title": "해변과 여유",
      "img1": "assets/images/travel_4.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "하얏트",
      "keyword": "여유로움",
      "price": 30.0,
      "summary": "이솔리 해변 수영, 루체르 전망대, 파르니 마을 체험"
    },
    {
      "id": 5,
      "search_id": 1,
      "title": "시장과 오솔길",
      "img1": "assets/images/travel_5.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "쉐라톤",
      "keyword": "향토적",
      "price": 15.0,
      "summary": "라코나 시장 구경, 플로렌 언덕 트레킹, 바르미 오솔길 산책"
    },
    {
      "id": 6,
      "search_id": 1,
      "title": "성과 정원",
      "img1": "assets/images/travel_6.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "콘래드",
      "keyword": "고풍적",
      "price": 10.0,
      "summary": "페르노 성 방문, 사피르 정원 산책, 로살리 박물관"
    },
    {
      "id": 7,
      "search_id": 1,
      "title": "예술 여행",
      "img1": "assets/images/travel_7.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "한화",
      "keyword": "역사적",
      "price": 20.0,
      "summary": "엘토아 해양 박물관, 나리아 성벽 투어, 세라노 거리 예술"
    }];*/