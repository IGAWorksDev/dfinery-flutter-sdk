# dfinery_sample

Dfinery Flutter Plugin 예제 앱.

## iOS 빌드 테스트

### SPM 빌드 (기본)

Flutter 3.44+에서 SPM이 기본 활성화됩니다.

```bash
flutter clean
flutter pub get
flutter build ios --no-codesign
```

### CocoaPods 빌드

```bash
flutter clean
flutter pub get
flutter build ios --no-codesign
```

CocoaPods 빌드를 위해서는 먼저 SPM을 비활성화해야 합니다. 아래 "SPM ↔ CocoaPods 전환 방법" 참조.

### 의존성 버전 확인

| 빌드 방식 | DfinerySDK 버전 | 설정 파일 |
|-----------|-----------------|-----------|
| SPM | 2.6.0 | `ios/dfinery_plugin/Package.swift` |
| CocoaPods | 2.5.1 | `ios/dfinery_plugin.podspec` |

**SPM 버전 확인:**
```bash
cat ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved | grep -A5 "dfinery"
```

**CocoaPods 버전 확인:**
```bash
cat ios/Podfile.lock | grep DfinerySDK
```

## SPM ↔ CocoaPods 전환 방법

### SPM 비활성화 (프로젝트 단위)

`pubspec.yaml`에서 설정:

```yaml
flutter:
  config:
    enable-swift-package-manager: false
```

이 설정은 해당 프로젝트의 모든 기여자에게 적용됩니다.

### SPM 비활성화 (전역)

```bash
flutter config --no-enable-swift-package-manager
```

이 설정은 현재 사용자의 모든 프로젝트에 적용됩니다.

### SPM → CocoaPods 전환

SPM으로 한 번이라도 빌드한 프로젝트는 Xcode에 SPM 참조가 남아있어 추가 작업이 필요합니다.

```bash
# 1. pubspec.yaml에 추가:
#    flutter:
#      config:
#        enable-swift-package-manager: false

# 2. SPM 관련 파일 삭제
rm -rf ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/swiftpm

# 3. Xcode에서 SPM 참조 제거 (필수)
#    - Xcode에서 ios/Runner.xcworkspace 열기
#    - Project Navigator에서 프로젝트 선택
#    - Package Dependencies 탭에서 FlutterGeneratedPluginSwiftPackage 삭제
#    - Runner 타겟 > General > Frameworks, Libraries, and Embedded Content에서
#      FlutterGeneratedPluginSwiftPackage 삭제

# 4. 클린 빌드
flutter clean
flutter pub get
flutter build ios --no-codesign
```

### CocoaPods → SPM 전환

```bash
# 1. pubspec.yaml에서 enable-swift-package-manager: false 제거 (있는 경우)

# 2. CocoaPods 제거
cd ios
pod deintegrate
cd ..

# 3. CocoaPods 관련 파일 삭제
rm -rf ios/Podfile ios/Podfile.lock ios/Pods ios/.symlinks

# 4. xcconfig에서 CocoaPods 참조 제거
# ios/Flutter/Debug.xcconfig, Release.xcconfig에서
# #include "Pods/Target Support Files/..." 라인 삭제

# 5. 클린 빌드
flutter clean
flutter pub get
flutter build ios --no-codesign
```

### 참고

> ⚠️ [CocoaPods Specs 저장소가 2026년 12월 부로 읽기 전용으로 전환](https://blog.cocoapods.org/CocoaPods-Specs-Repo/)되므로 Flutter iOS 빌드 시 SPM 사용을 권장합니다.

## iOS Notification Service Extension 설정

푸시 알림에서 이미지 등 미디어를 표시하려면 Notification Service Extension을 생성하고 `DfinerySDKServiceExtension`을 연동해야 합니다.

### 1. Notification Service Extension 생성

1. Xcode에서 프로젝트 열기
2. File → New → Target → "Notification Service Extension" 선택
3. Product Name 입력 (예: `NotificationServiceExtension`)
4. Finish 클릭

### 2. DfinerySDKServiceExtension SPM 패키지 추가

1. Project Navigator에서 프로젝트 파일 선택
2. 생성한 Service Extension 타겟 선택
3. "General" 탭 → "Frameworks, Libraries, and Embedded Content" 섹션
4. "+" 버튼 클릭 → "Add Package Dependency..."
5. 패키지 URL 입력: `https://github.com/IGAWorksDev/dfinery-ios-sdk`
6. `DfinerySDKServiceExtension` 라이브러리 선택 후 추가

### 참고

- `dfinery_plugin`은 `DfinerySDK`만 포함합니다.
- `DfinerySDKServiceExtension`은 Service Extension 타겟에서 별도로 추가해야 합니다.
- Flutter 3.44+에서 플러그인은 Swift Package Manager를 통해 관리됩니다.
