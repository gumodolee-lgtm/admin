# Claude Code Harness

AI 자율 개발 시 품질과 안전을 보장하는 5단계 워크플로우 프레임워크.

## 하네스란?

AI가 마음대로 코드를 작성하다 프로젝트를 망치거나 환각(Hallucination)에 빠지지 않도록, **안전벨트(마구)처럼 규칙, 검증 방법, 실행 흐름을 미리 설계**해 주는 작업 환경입니다.

## 5-Verb Workflow

```
/harness-setup  →  /harness-plan  →  /harness-work  →  /harness-review  →  /harness-release
   환경 파악          계획 수립          구현              검증                배포
```

| 단계 | 명령어 | 역할 | AI 역할 |
|------|--------|------|---------|
| 1 | `/harness-setup` | 프로젝트 스캔, 규칙 확인 | Observer |
| 2 | `/harness-plan` | Plans.md 생성, 수용 기준 정의 | Planner |
| 3 | `/harness-work` | 승인된 계획에 따라 코드 구현 | Generator |
| 4 | `/harness-review` | 보안/성능/품질/준수 4관점 리뷰 | Evaluator |
| 5 | `/harness-release` | 커밋, CHANGELOG, PR 생성 | Releaser |

## 핵심 설계 원칙

### 1. 역할 분리 (GAN Principle)
AI가 자기 코드를 무조건 합리화하는 **자기 편향**을 방지합니다.
- **Planner**: 요구사항 분석, 수용 기준 정의
- **Generator**: 승인된 계획에 따라 코드만 작성
- **Evaluator**: 계획 대비 결과를 객관적으로 검증

### 2. 안전 훅 (Safety Hooks)
브레이크 없는 자동차를 방지합니다.
- `rm -rf /`, `sudo`, `git push --force`, `DROP TABLE` 등 파괴적 명령어 사전 차단
- `.env`, 자격증명 파일 내용 출력 차단

### 3. 품질 게이트 (Quality Gates)
| 단계 | 통과 기준 |
|------|----------|
| Plan | 사용자 명시적 승인 |
| Work | 빌드 성공 + 린트 통과 |
| Review | CRITICAL 0개 + HIGH 0개 |
| Release | Review 통과 + 테스트 통과 |

## 설치

### 자동 설치 (권장)
```bash
./install.sh
```

### 수동 설치
```bash
# 규칙 복사
cp rules/harness.md ~/.claude/rules/

# 커맨드 복사
cp commands/harness-*.md ~/.claude/commands/

# settings.json에 hooks 추가 (install.sh 참고)
```

## VS Code 자동 부트 (폴더 열면 하네스 자동 시작)

### 원리
VS Code의 `runOn: "folderOpen"` task가 폴더를 열 때마다 `claude-code://` 프로토콜로
Claude Code 세션을 열면서 하네스 프롬프트를 자동 주입합니다.

### 프로젝트에 자동 부트 적용하기

```bash
# install.sh 실행 후 (위 설치 완료 상태에서)
~/.claude-harness/init-project.sh ~/my-project
```

이 명령은 대상 프로젝트에 다음을 복사합니다:
- `.vscode/tasks.json` — 폴더 열릴 때 자동 실행 task
- `progress.md` — 세션 간 진행 상황 추적
- `CLAUDE.md` — 프로젝트 규칙 템플릿 (이미 있으면 건너뜀)

### VS Code에서 자동 task 허용 (최초 1회)

1. `Ctrl+Shift+P` → `Tasks: Manage Automatic Tasks in Folder`
2. `Allow Automatic Tasks in Folder` 선택
3. VS Code 재시작

### 체감 동작

```
VS Code로 폴더 열기
  → claude-harness-boot task 자동 실행
    → Claude Code 새 세션 + 하네스 프롬프트 자동 입력
      → Enter 한 번 → 하네스 세션 시작!
```

### OS별 tasks.json 차이

| OS | command 부분 |
|----|-------------|
| Windows | `start "" "claude-code://new?prompt=..."` |
| macOS | `open "claude-code://new?prompt=..."` |
| Linux | `xdg-open "claude-code://new?prompt=..."` |

현재 기본값은 **Windows**로 설정되어 있습니다.

### Claude Code 기본 모드 설정 (선택)

VS Code 설정(`Ctrl+,`) → Extensions → Claude Code:
- `initialPermissionMode` → `plan` 으로 변경
- 새 세션에서 Claude가 먼저 계획을 세우고 승인 요청부터 하게 됩니다

## 사용 예시

```
# 1. 새 프로젝트 시작
/harness-setup

# 2. 기능 계획 수립 (코드 작성 전!)
/harness-plan 사용자 로그인 기능 추가

# 3. 사용자가 계획 승인 후 구현
/harness-work          # 다음 미완료 페이즈 실행
/harness-work 2        # 특정 페이즈만 실행
/harness-work all      # 전체 페이즈 한번에 실행

# 4. 4관점 리뷰
/harness-review

# 5. 커밋 및 배포
/harness-release
```

## 기존 도구와의 통합

- **cross-flow-review**: `/harness-review`에서 자동 포함
- **vibecoding-security**: `/harness-review` 보안 관점에 통합
- **development-workflow**: `/harness-work`에서 TDD 접근법 적용
- **git-workflow**: `/harness-release`에서 커밋 규칙 적용
- **planner agent**: `/harness-plan`에서 활용
- **code-reviewer agent**: `/harness-review`에서 활용
- **security-reviewer agent**: `/harness-review`에서 활용

## 파일 구조

```
admin/
├── README.md                # 이 파일
├── install.sh               # 글로벌 설치 스크립트
├── init-project.sh          # 프로젝트별 자동부트 초기화
├── .vscode/
│   └── tasks.json           # 폴더 열릴 때 자동 실행 task
├── rules/
│   └── harness.md           # 핵심 규칙 (자동 적용)
├── commands/
│   ├── harness-setup.md     # Step 1: 환경 초기화
│   ├── harness-plan.md      # Step 2: 계획 수립
│   ├── harness-work.md      # Step 3: 구현
│   ├── harness-review.md    # Step 4: 검증
│   └── harness-release.md   # Step 5: 배포
└── templates/
    ├── CLAUDE.md             # 프로젝트 규칙 템플릿
    ├── progress.md           # 진행 상황 추적 템플릿
    └── harness-prompt.txt    # 자동 부트 프롬프트 원문
```

## 라이선스

MIT
