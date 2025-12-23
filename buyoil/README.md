# buyoil

Buyoil

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

1207 공유 정보
- temp-code/112603pm : 시연용? 으로 최종 진행 했던 버전
  - temp로 시작하는 commit 정리 안됨
- temp-code/1126 : 시연버전 이후, 일부 기능 추가 된 버전 (메시지 텍스트 변경, 세팅화면에 [CMD]OPENB# 추가) 
  - temp로 시작하는 commit 정리 안됨
- feature/temp1207 : 시연버전 이후, 일부 기능 테스트 진행 버전
  - temp로 시작하는 commit 정리 안됨

- main : 11/04 기준 코드 관리 되고 있던 버전
남은 항목 
- [V] [ANS] 만 응답 처리 
- [V] postdata / postper ok 및 재시도 로직 추가
    postper 먼저 -> ok -> postData -> ok ok 2회 진행
- [V] 로딩 애니메이션 
- [V] 시작 버튼 액션 
- [] 설정 기능
- [V] sleep 안뜸 -> 기기 연결시에만 체크하던 것에서 기기 연결 안해도 보낼 수 있으면 계속 보내도록 수정 함
- "[CMD]SLEEP#" -> [ANS]STM_SLEEP#  -> 첫페이지로
- [V] driver`s page 처리
- [] MCU->APP. [CMD]UPDATE#
- [] APP -> MCU. [ANS]OK#
- [] APP -> MCU 시간 전달
- [] MCU -> APP [ANS]DONE#
- [V] Toast Custom 수정 
- [V] [ANS]FAIL#
  1) 이 메시지 받으면 기계가 고장인거여서 무조건 첫페이지로 가고 5초간 팝업 띄움
  2) 메시지 팝업 : A system error has occurred. Please try again later.
- [V] [ANS]REJECT# ??
  1) 이 메시지는 고객 폰 넘버 보냈는데 이 사람이 고객이 아닐 경우에 나옴 -> 폰넘버 입력하는 페이지에 대기한 상태에서 팝업 메시지 띄워줌
  2) Access denied. Please check your information.
  3) 5번 연속으로 반복되면 첫페이지로 복귀
- [V] [ANS]FULL#
  1) 이 메시지는 [CMD]HANDSHAKE# 을 보냈는데 기름통이 꽉 찻을 때 나옴 -> 첫페이지로 복귀 + 팝업 메시지 듸움
  2) The container is full. Please contact staff
- [V] 연결 끊기면 stm32 자동 재연결 시도 