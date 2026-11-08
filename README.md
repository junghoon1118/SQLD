# SQLD 모의 시험장

학교 교실을 재현한 SQL 개발자(SQLD) 자격시험 모의고사 웹앱입니다. 시험장에서 떨지 않도록 실제 시험 분위기를 연습하는 것이 목표입니다.

- 무작위 좌석 배정, 자리에서 바라본 교실 시야(Canvas로 직접 그림)
- 감독관 2~3명의 순찰, 본인 확인, 손 든 수험생 응대
- 교내 방송(Web Speech API)과 소음(Web Audio API로 합성): 기침, 종이 넘김, 의자, 펜 떨어뜨림, 휴대폰 진동 등
- 문제지와 OMR 답안지 분리, 컴퓨터용 사인펜과 수정테이프, 중복 표기 오답 처리, 답안지 교체
- 1과목 10문항, 2과목 40문항, 총 100점 채점과 과목별 과락, 문항별 해설
- PWA: 휴대폰 홈 화면에 설치, 오프라인 실행

문제는 모두 자체 제작했으며 공식 시험과 관련이 없습니다.

## 파일 구조

| 파일 | 역할 |
| --- | --- |
| `src/app.html` | 앱 본문(스타일, 화면, 스크립트, 문제 데이터). 수정은 여기서 합니다. |
| `build.ps1` | `src/app.html`을 감싸 배포용 `index.html`을 만듭니다. |
| `index.html` | 배포되는 페이지 (직접 고치지 말고 build로 생성) |
| `manifest.webmanifest`, `sw.js` | PWA 설치 정보와 오프라인 캐시 |
| `make-icons.ps1`, `icons/` | 앱 아이콘 생성 스크립트와 결과물 |

## 수정 후 다시 만들기

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

`sw.js`의 `CACHE` 이름(예: `sqld-exam-v1` → `v2`)을 바꾸면 설치된 앱의 오래된 캐시가 정리됩니다.

## 배포

GitHub Pages (Settings → Pages → Deploy from a branch → `main` / `(root)`)
