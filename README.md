# 포토샷 (Photoshot)

브라우저에서 동작하는 이미지 보정 웹 앱입니다. 포토샵의 일부 기능(선택 영역, 크롭/리사이즈, 블러/노이즈, 선택색상, 레벨, 곡선 등)을 순수 HTML/CSS/JavaScript로 구현했습니다. 모든 처리는 브라우저 안에서만 이루어지며 서버로 이미지가 전송되지 않습니다.

## 기능

- 이미지 업로드 및 다운로드 (PNG)
- 선택 영역: 올가미, 브러쉬(추가/빼기), 페더, 선택 반전/해제
- 캔버스: 크롭, 리사이즈(비율 고정 옵션)
- 효과: 가우시안 블러, 노이즈
- 선택색상: 색상 범위별 CMY/RGB 밸런스 조정
- 레벨: 입력/출력 최소·최대값, 감마
- 곡선: 포인트 추가/삭제/드래그가 가능한 커브 에디터
- 실행 취소(undo) / 되돌리기(원본으로) / 새 작업 시작(확인 후 초기화)
- PWA로 홈 화면에 추가 가능 (`manifest.json`, 표시 이름: "포토샷")
- 로그인(선택 사항): [nolging.github.io](https://nolging.github.io)와 계정을 공유하는 아이디/비밀번호 로그인. 로그인한 사용자만 "프로필 사진 자동화 모드"를 쓸 수 있고, 그 모드가 수행하는 각 단계(리사이즈 크기·블러·노이즈·선택색상·레벨·곡선·입술 레이어)를 직접 세팅해서 계정별로 저장할 수 있습니다.

## 로컬에서 실행하기

별도의 빌드 과정이 없습니다. `index.html`을 브라우저에서 바로 열면 됩니다.

## 로그인 / 자동화 모드 설정 연결하기 (최초 1회)

로그인은 [nolging.github.io](https://nolging.github.io)와 같은 Supabase 프로젝트(같은 계정)를 사용합니다. 저장소 관리자가 처음 한 번만 아래를 해주면 됩니다:

1. nolging 쪽 Supabase 프로젝트의 **Project Settings → API**에서 `Project URL`과 `anon public` 키를 복사합니다. (anon 키는 RLS로 보호되어 공개돼도 안전합니다.)
2. `index.html`에서 `SUPABASE_URL`/`SUPABASE_ANON_KEY` 상수를 검색해 값을 채워 넣습니다. (`// ---------- Supabase 로그인 ----------` 주석 아래)
3. 그 Supabase 프로젝트의 **SQL Editor**에서 [`supabase/photoshot_automation_settings.sql`](supabase/photoshot_automation_settings.sql)을 붙여넣어 한 번 실행합니다. (자동화 모드 설정을 계정별로 저장하는 포토샷 전용 테이블이며, nolging 앱 자체에는 영향이 없습니다.)
4. `main`에 커밋/푸시하면 자동 배포됩니다.

로그인 계정 자체(아이디/비밀번호 발급, 승인)는 nolging 쪽에서 관리자가 생성/승인한 계정을 그대로 사용합니다 — 포토샷에는 별도의 가입 화면이 없습니다.

## GitHub Pages 배포

`.github/workflows/deploy-pages.yml` 워크플로가 `main` 브랜치에 푸시될 때마다 저장소 루트를 GitHub Pages로 배포합니다.

처음 한 번은 저장소 관리자가 GitHub 저장소 설정에서 Pages를 활성화해야 합니다:

1. 저장소 **Settings → Pages**로 이동
2. **Build and deployment → Source**를 **GitHub Actions**로 설정

설정 후에는 `main`에 푸시할 때마다 자동으로 재배포되며, 배포된 사이트는 `https://<GitHub 사용자명>.github.io/<저장소명>/` 주소에서 접근할 수 있습니다.

> GitHub Pages용 `github-pages` 배포 환경은 기본적으로 저장소의 기본 브랜치(`main`)에서만 배포를 허용합니다. 다른 브랜치에 푸시해도 사이트에는 영향이 없으며, 기능 브랜치는 `main`으로 병합된 뒤에만 배포됩니다.
