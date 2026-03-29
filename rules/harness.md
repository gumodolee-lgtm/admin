# Harness System - Core Rules

> AI 자율 개발 시 품질과 안전을 보장하는 워크플로우 프레임워크.
> 모든 프로젝트에 자동 적용된다.

## Harness Workflow (5-Verb System)

모든 기능 개발은 반드시 아래 순서를 따른다:

```
/harness-setup → /harness-plan → /harness-work → /harness-review → /harness-release
```

### 워크플로우 강제 규칙

1. **코드 작성 전 계획 필수**: 사용자가 기능을 요청하면, 바로 코드를 짜지 말고 `/harness-plan` 워크플로우를 제안하라
2. **계획 승인 없이 구현 금지**: Plans.md가 사용자에게 승인되기 전까지 코드 작성을 시작하지 마라
3. **구현 후 리뷰 필수**: 코드 작성이 끝나면 반드시 `/harness-review` 관점의 검증을 수행하라
4. **커밋 전 리뷰 통과 필수**: CRITICAL/HIGH 이슈가 해결되기 전에는 커밋하지 마라

## Role Separation (GAN Principle)

AI의 자기 편향(self-bias)을 방지하기 위해, 역할을 분리한다:

| Role | Phase | Responsibility |
|------|-------|---------------|
| **Planner** | /harness-plan | 요구사항 분석, 계획 수립, 수용 기준 정의 |
| **Generator** | /harness-work | 승인된 계획에 따라 코드 구현 |
| **Evaluator** | /harness-review | 구현 결과를 계획 대비 검증, 다각도 리뷰 |

- Planner가 만든 기준으로 Evaluator가 평가한다 (Generator가 자기 코드를 평가하지 않음)
- 각 역할은 서로 다른 agent로 실행하여 교차 검증을 보장한다

## Safety Rails

### 절대 금지 명령어 (Hooks로 차단)
- `rm -rf /`, `rm -rf ~`, `rm -rf .` 등 재귀 삭제
- `sudo` 권한 상승
- `git push --force` to main/master
- `DROP DATABASE`, `DROP TABLE` (프로덕션)
- `.env`, 자격증명 파일 내용 출력

### 작업 범위 제한
- 사용자가 요청하지 않은 파일을 임의로 삭제하지 마라
- 승인된 계획 범위 밖의 리팩토링을 하지 마라
- 새로운 라이브러리를 임의로 도입하지 마라

## Quality Gates

각 단계별 통과 기준:

| Phase | Gate |
|-------|------|
| Plan | 사용자 승인 (명시적 "승인", "진행", "OK" 등) |
| Work | 빌드 성공 + 린트 통과 |
| Review | CRITICAL 0개 + HIGH 0개 |
| Release | Review 통과 + 테스트 통과 |

## Integration with Existing Rules

이 하네스 시스템은 기존 규칙들과 함께 작동한다:
- `cross-flow-review.md`: /harness-review에서 자동 포함
- `development-workflow.md`: /harness-work에서 TDD 접근법 적용
- `git-workflow.md`: /harness-release에서 커밋/PR 규칙 적용
- `vibecoding-security.md`: /harness-review에서 보안 검증 적용
