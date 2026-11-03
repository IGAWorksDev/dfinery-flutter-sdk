## 2.0.0 (2025-07-14)

<details open>
<summary>EN</summary>

##### Breaking Changes
- Flutter SDK minimum version upgraded from 1.20.0 to 3.24.0
- Dart SDK minimum version upgraded from 2.12.0 to 3.5.0
- iOS deployment target raised from 12.0 to 15.0 (required by Xcode 27)

##### Added
- Swift Package Manager (SPM) support for iOS dependency management
- Package.swift file for SPM-based iOS projects

##### Changed
- Android SDK updated to version 2.7.4
- iOS DfinerySDK updated to version 2.5.1
- iOS DfinerySDKServiceExtension updated to version 2.5.1

##### Notes
- CocoaPods remains supported for backward compatibility
- Existing iOS projects can continue using CocoaPods or migrate to SPM

##### Versions

- **Android**
  - Dfinery Android SDK 2.7.4
- **iOS**
  - Dfinery iOS SDK 2.5.1
  - Dfinery iOS SDK Service Extension 2.5.1

</details>

<details open>
<summary>KO</summary>

##### 주요 변경사항 (Breaking Changes)
- Flutter SDK 최소 버전이 1.20.0에서 3.24.0으로 업그레이드됨
- Dart SDK 최소 버전이 2.12.0에서 3.5.0으로 업그레이드됨
- iOS deployment target이 12.0에서 15.0으로 상향됨 (Xcode 27 최소 요구사항)

##### 추가됨
- iOS 의존성 관리를 위한 Swift Package Manager (SPM) 지원
- SPM 기반 iOS 프로젝트를 위한 Package.swift 파일

##### 변경됨
- Android SDK 버전 2.7.4로 업데이트
- iOS DfinerySDK 버전 2.5.1로 업데이트
- iOS DfinerySDKServiceExtension 버전 2.5.1로 업데이트

##### 주요 사항
- 하위 호환성을 위해 CocoaPods 계속 지원
- 기존 iOS 프로젝트는 CocoaPods를 계속 사용하거나 SPM으로 마이그레이션 가능

##### 버전 정보

- **Android**
  - Dfinery Android SDK 2.7.4
- **iOS**
  - Dfinery iOS SDK 2.5.1
  - Dfinery iOS SDK Service Extension 2.5.1

</details>

## 1.0.2 (2025-10-28)

<details open>
<summary>EN</summary>

##### Fixed
- In applications with the Dfinery SDK installed and push integration completed, the issue where push notifications received through a route other than Dfinery Console were notified with empty content has been resolved. [Android]

##### Versions

- **Android**
  - Dfinery Android SDK 2.4.3
- **iOS**
  - Dfinery iOS SDK 2.3.2

</details>

<details open>
<summary>KO</summary>

##### 고쳐짐
- Dfinery SDK가 탑재되고 푸시 연동이 완료된 애플리케이션에서, Dfinery Console을 통하지 않고 다른 경로로 수신된 푸시 알림의 내용이 비어있는 상태로 노출되는 문제가 해결되었습니다. [Android]

##### 버전 정보

- **Android**
  - Dfinery Android SDK 2.4.3
- **iOS**
  - Dfinery iOS SDK 2.3.2

</details>

## 1.0.1 (2025-01-27)

<details open>
<summary>EN</summary>

##### Notes

- Updated README.md

</details>
<details open>
<summary>KO</summary>

##### 주요 사항

- README.md 업데이트

</details>

## 1.0.0 (2025-07-09)

<details open>
<summary>EN</summary>

##### Notes

- Initial release

</details>
<details open>
<summary>KO</summary>

##### 주요 사항

- 최초 배포

</details>
