# SOAFF

## 목차

1. [팀원 소개](#팀원-소개)
2. [프로젝트 소개](#프로젝트-소개)
3. [배경](#배경)
4. [목표](#목표)
5. [기술 스택](#기술-스택)
6. [협업 툴](#협업-툴)
7. [설치 및 사용법](#설치-및-사용법)


## 팀원 소개

### SOAFF 팀구성 및 역할

| 황세현                | 백승준            | 서석환            | 이봉욱            | 정형진            |
|--------------------|----------------|----------------|----------------|----------------|
| @HwangSettong                  | @minit723      | @shseo232      | @kiv9908              | @nijnuyhj              |
| 팀장, 기획, 프론트엔드, 백엔드 | 기획, 프론트엔드, 백엔드 | 기획, 프론트엔드, 백엔드 | 기획, 프론트엔드, 백엔드 | 기획, 프론트엔드, 백엔드 |



## 프로젝트 소개

제로웨이스트 비누 쇼핑몰은 친환경 비누를 판매하는 온라인 플랫폼입니다. 이 프로젝트는 지속 가능한 소비를 촉진하고 환경 보호에 기여하는 것을 목표로 합니다.

## 배경

최근 몇 년간 환경 보호와 지속 가능한 소비에 대한 관심이 급증하면서, 제로웨이스트 라이프스타일을 실천하는 소비자들이 증가하고 있습니다. 동구밭의 성공 사례를 참고하여, 제로웨이스트 비누 쇼핑몰을 개발하게 되었습니다. 이 쇼핑몰은 단순히 제품을 판매하는 것을 넘어, 지속 가능한 소비를 촉진하고 환경 보호에 기여하는 것을 목표로 합니다.

## 목표

1. 제로웨이스트 비누의 판매 촉진
2. 지속 가능한 소비 문화 확산
3. 디지털 솔루션을 통한 고객 편의성 증대
4. 고객 참여 유도 및 보상
5. 친환경 제품 라인업 확대
6. ESG 경영 실천

## 기술 스택

- **프레임워크 및 언어**: STS(Spring Tool Suite), JSP, JAVA
  ![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
- **클라우드 서비스**: AWS
  ![AWS](https://img.shields.io/badge/Amazon%20AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
- **데이터베이스**: MySQL
  ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
- **프론트엔드**: HTML5, CSS3, JQuery, BootStrap, JavaScript(JS)
  ![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
  ![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
  ![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
  ![JQuery](https://img.shields.io/badge/JQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white)
  ![BootStrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)
- **결제 시스템**: PortOne
  ![PortOne](https://img.shields.io/badge/PortOne-000000?style=for-the-badge&logo=portone&logoColor=white)
- **이메일 서비스**: NAVER MAIL
  ![NAVER](https://img.shields.io/badge/NAVER-03C75A?style=for-the-badge&logo=naver&logoColor=white)

## 협업 툴

- Eclipse
  ![Eclipse](https://img.shields.io/badge/Eclipse-2C2255?style=for-the-badge&logo=eclipse&logoColor=white)
- GitHub
  ![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
- ERD Cloud
  ![ERD Cloud](https://img.shields.io/badge/ERD%20Cloud-1C1C1C?style=for-the-badge&logo=erdcloud&logoColor=white)
- Figma
  ![Figma](https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white)
- Google Sheets
  ![Google Sheets](https://img.shields.io/badge/Google%20Sheets-34A853?style=for-the-badge&logo=googlesheets&logoColor=white)
- Notion
  ![Notion](https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white)
- Google Calendar
  ![Google Calendar](https://img.shields.io/badge/Google%20Calendar-4285F4?style=for-the-badge&logo=googlecalendar&logoColor=white)

## 설치 및 사용법

### 1. 사전 요구사항

- JDK 8 이상
- STS 설치
- MySQL 데이터베이스 설정
- AWS 계정 설정

### 2. 설치 방법

1. **레포지토리 클론**
    ```sh
    git clone https://github.com/yourusername/zerowaste-soap-shop.git
    ```
2. **프로젝트 열기**
  - Eclipse 또는 STS에서 프로젝트 열기
3. **데이터베이스 설정**
  - `src/main/resources/application.properties` 파일에서 MySQL 설정
4. **의존성 설치**
    ```sh
    mvn install
    ```
5. **애플리케이션 실행**
    ```sh
    mvn spring-boot:run
    ```

### 3. 사용 방법

- 웹 브라우저에서 `http://localhost:8080` 접속
- 회원가입 및 로그인 후 비누 상품 구매 가능


## 주요 기능 📦

### 사용자 인증
- 로그인 및 회원가입
- 이메일 인증을 통한 사용자 인증 기능
- 탈퇴 및 로그아웃 기능

### 상품 관리
- 상품 등록, 수정, 삭제
- 상품 목록 조회 및 상세 보기

### 리뷰 관리
- 상품 리뷰 작성, 수정, 삭제
- 리뷰 목록 조회 및 상세 보기

### 주문 관리
- 주문 생성, 수정, 취소
- 주문 목록 조회 및 상세 보기
- 주문 상태 관리

### 장바구니 관리
- 장바구니에 상품 추가, 수정, 삭제
- 장바구니 목록 조회

### 포인트 관리
- 포인트 적립 및 사용
- 포인트 내역 조회

### 문의 관리
- 고객 문의 작성, 수정, 삭제
- 문의 목록 조회 및 상세 보기

### 대시보드
- 관리자 대시보드
- 매출 통계 및 분석

### 주문 취소 관리
- 주문 취소 요청 처리
- 주문 취소 목록 조회

### 메일 관리
- 이메일 인증
- 비밀번호 찾기

### 통계 관리
- 매출 통계
- 사용자 통계
- 상품 통계
