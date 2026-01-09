# CLAUDE.md - Project Configuration

## Project Overview

- **Project Name**: [项目名称]
- **Project Type**: Web Application / API Service / Full-stack App
- **Status**: Development / Maintenance / Enhancement

## Tech Stack

### Frontend
- Framework: React / Vue / Next.js / ...
- UI Library: Tailwind CSS / Ant Design / MUI / ...
- State Management: Redux / Zustand / Pinia / ...

### Backend
- Runtime: Node.js / Python / Go / ...
- Framework: Express / NestJS / FastAPI / ...
- Database: PostgreSQL / MySQL / MongoDB / ...
- ORM: Prisma / TypeORM / Sequelize / ...

### Infrastructure
- Cloud: AWS / GCP / Azure / ...
- Container: Docker / Kubernetes
- CI/CD: GitHub Actions / GitLab CI / ...

## Project Structure

```
src/
├── components/     # UI コンポーネント
├── pages/          # ページ / ルーティング
├── services/       # API 呼び出し / ビジネスロジック
├── hooks/          # カスタムフック
├── utils/          # ユーティリティ関数
├── types/          # 型定義
└── styles/         # スタイル
```

## Development Commands

```bash
# Install dependencies
npm install

# Development server
npm run dev

# Build for production
npm run build

# Run tests
npm run test

# Lint
npm run lint
```

## Code Conventions

### Naming
- Components: PascalCase (`UserProfile.tsx`)
- Functions/Variables: camelCase (`getUserData`)
- Constants: UPPER_SNAKE_CASE (`API_BASE_URL`)
- Files: kebab-case (`user-profile.tsx`) or PascalCase for components

### Git Branch
- Feature: `feature/xxx`
- Bugfix: `fix/xxx`
- Release: `release/x.x.x`

### Commit Message
```
feat: 新機能追加
fix: バグ修正
docs: ドキュメント更新
refactor: リファクタリング
test: テスト追加・修正
chore: その他の変更
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET    | /api/users | ユーザー一覧取得 |
| POST   | /api/users | ユーザー作成 |
| ...    | ...        | ... |

## Environment Variables

```env
# .env.example
DATABASE_URL=
API_KEY=
JWT_SECRET=
```

## Key Business Logic

<!-- 重要なビジネスロジックや注意点を記載 -->

1. **認証フロー**: JWT + Refresh Token 方式
2. **権限管理**: RBAC（Role-Based Access Control）
3. **...**: ...

## Known Issues / Tech Debt

- [ ] TODO: ユニットテストのカバレッジ向上
- [ ] TODO: パフォーマンス最適化（画像遅延読み込み）
- [ ] FIXME: エラーハンドリングの統一

## Claude Instructions

### Working with this project

1. このプロジェクトのコードを修正する際は、既存のコード規約に従ってください
2. 新しい依存関係を追加する前に、既存の依存関係で解決できないか確認してください
3. TypeScript の型定義を省略しないでください

### Prompt Files

| File | Purpose |
|------|---------|
| `.claude/prompts/estimate_prompt.md` | 見積書生成用プロンプト |
| `.claude/prompts/review_prompt.md` | コードレビュー用プロンプト |
| `.claude/prompts/docs_prompt.md` | ドキュメント生成用プロンプト |

### Preferred Response Style

- 日本語でコメントを書いてください
- コードの説明は日本語 or 中国語で
- 見積書は日本語フォーマットで出力

## Contact

- Tech Lead: [Name] <email@example.com>
- PM: [Name] <email@example.com>

---

*Last Updated: YYYY-MM-DD*
