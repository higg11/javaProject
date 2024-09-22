## 🌍 Spring-Project-NatureCycle

### 프로젝트 소개
🌱 '자연을 위한 순환, 지구를 위한 미래'라는 컨셉의 친환경기업 홈페이지입니다.
* 배포 url : 43.201.169.151:8080/team
* 유저 id/pw : test / 1234
* 관리자 id/pw : test / 1212
  
---

### 개발 기간
🕘 24.08.01 - 24.09.02

---

### 멤버구성
🙋‍♂️ 팀장 정형인 : 상품구매(장바구니,찜,주문), 예약시스템, 매출관리페이지, 1대1문의 게시판, 발표

🙍‍♂️ 조원 황제윤 : 상품관리(상품등록, 상품리스트), 메인페이지 CSS, ppt제작

🙍‍♂️ 조원 김민재 : 로그인, 회원가입, ID찾기, PW찾기, 마이페이지

---

### 개발환경
* ![Static Badge](https://img.shields.io/badge/backend-Java-orange)
* ![Static Badge](https://img.shields.io/badge/front-HTML-blue)
![Static Badge](https://img.shields.io/badge/front-CSS-blue)
![Static Badge](https://img.shields.io/badge/front-Javascript-blue)
, ![Static Badge](https://img.shields.io/badge/front-Bootstrap-blue)
* ![Static Badge](https://img.shields.io/badge/framework-Spring%20Tool%20Suite%203-green)
, ![Static Badge](https://img.shields.io/badge/build%26tool-%20Maven-purple)
* ![Static Badge](https://img.shields.io/badge/DB-%20MySql-skyblue)
* ![Static Badge](https://img.shields.io/badge/server-%20ApacheTomcat%209.0-yellow)
  
---

### ERD Diagram
![ERD](https://github.com/user-attachments/assets/f45c49b6-d912-4d4e-b600-f4d9a03c1aa0)

---

### 주요기능
⭐ 회원가입 및 로그인
* 회원가입 validation : 아이디(4자리이상), 비밀번호(9자리이상, 소문자/숫자/특수키 조합), 이메일인증(Google SMTP lib), 주소입력(다음 api)
* 로그인 : ID/PW찾기
![회원가입_로그인](https://github.com/user-attachments/assets/efd41c43-15dd-41db-b11e-6a275fa2671d)


⭐ 상품 및 재고관리(관리자)
* 상품등록(관리자) : 상품등록/수정/삭제/리스트, 재고관리리스트
![상품등록](https://github.com/user-attachments/assets/a72e15ea-5790-41db-a331-9632dff7d08d)


⭐ 상품구매(유저)
* 상품 정보 : 메인페이지, 전체상품보기, 상품상세보기
* 장바구니/찜 : 장바구니 수량 표시(ajax), 장바구니 담기, 찜하기, 찜리스트에서 장바구니 추가(드래그앤드롭)
![주문](https://github.com/user-attachments/assets/5a5c112d-3885-4dfd-902f-e7a687367861)


⭐ 예약하기
* 예약하기(유저) : 픽업서비스 예약, 포인트 적립, 재활용센터위치 검색(카카오 api)
* 예약관리(관리자) : 예약상황(달력표시), 예약확정/취소
![예약](https://github.com/user-attachments/assets/60422670-5928-4ca4-a705-6d2e1795d620)


⭐ 매출관리(관리자)
* 매출 그래프(chart.js)
* 매출관리페이지 : 당일매출/상세보기(ajax), 월매출 그래프(chart.js), 매출리스트(검색기능)
![매출](https://github.com/user-attachments/assets/89424c85-a6c9-41dd-8c04-9b32d844eef0)


⭐ 1대1문의
* 1대1문의하기, 문의사항 확인(유저)
* 문의리스트, 문의답변하기(관리자)
![문의](https://github.com/user-attachments/assets/32001108-837c-455a-a2fe-287d50be3c88)


⭐ 포인트사용
* 기부하기 : 포인트 사용
* 포인트 적립 확인 : 상품구매시 적립, 리사이클 적립, 기부하기 차감
![기부](https://github.com/user-attachments/assets/1d8733a6-e6f2-40bf-bd41-c323f105a7c0)

---

### 
