# travel_planner

This project is a Travel Optimizer for Applied Mobile Programming(GAI3008)

# branches

main: main code for the project

android-device-run: code designed to generate better result in a real android device 
- chatGPT4 implementation
- Custom CSC Picker
- Horizontal rendering issues (horizontal length too short) resolved

# versions

main: 3.26.0-1.0.pre.308 기준


설정법
flutter --version 했을때
Flutter 3.26.0-1.0.pre.308 • channel [user-branch] • unknown source
Framework • revision cc7f76cf35 (8 weeks ago) • 2024-10-01 22:45:27 -0400
Engine • revision e0f049d692
Tools • Dart 3.6.0 (build 3.6.0-309.0.dev) • DevTools 2.40.0-dev.2
이 버전과 다른 경우 다운그레이드 필요 (CSC Picker로 인함)


- flutter --version
- flutter channel dev
- cd ~/flutter
- git checkout cc7f76cf35
- flutter upgrade
- flutter doctor 에서 버전 적용 되었는지 확인 후 버전 다운그레이드가 완료되었으면
- flutter pub get
- flutter run
해주시면 됩니다..!!


android-device-run: Flutter 3.28.0-2.0.pre.38577 • channel main • https://github.com/flutter/flutter.git
Framework • revision 0ffc4ce00e (2 days ago) • 2024-12-23 16:02:29 -0800
Engine • revision 0ffc4ce00e
Tools • Dart 3.7.0 (build 3.7.0-267.0.dev) • DevTools 2.41.0
flutter channel main, flutter upgrade



