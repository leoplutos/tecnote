# 前端项目技术选型 Checklist

| 分类 | 技术能力 | React 方案 | Vue 方案 | 备注 |
|---|---|---|---|---|
| **基础** | Framework | React 18 | Vue 3 | 核心框架 |
| **基础** | Language | TypeScript | TypeScript | 建议 Strict Mode |
| **基础** | Build Tool | Vite | Vite | 统一使用 Vite |
| **基础** | Package Manager | pnpm | pnpm | 建议锁定 pnpm / Node 版本 |
| **UI** | UI Component Library | MUI v5 | Naive UI | React / Vue 对应组件库 |
| **UI** | Styling | Emotion | Vue SFC / CSS | Emotion 是 MUI v5 默认样式引擎 |
| **路由** | Router | react-router-dom | Vue Router 5 | SPA 路由 |
| **路由** | File System Based Route | vite-plugin-pages | Vue Router 5 File-Based Routing | 根据文件结构生成路由 |
| **API** | Server State | @tanstack/react-query | @tanstack/vue-query | API Cache / Retry / Refetch / Loading 等 |
| **API** | HTTP Client | axios / openapi-fetch / fetch | axios / openapi-fetch / fetch | 建议结合 OpenAPI 方案决定 |
| **API** | API Contract | OpenAPI | OpenAPI | 前后端接口契约 |
| **API** | OpenAPI Type Generation | openapi-typescript | openapi-typescript | OpenAPI → TypeScript Types |
| **API** | API Client Generation | Orval / openapi-fetch | Orval / openapi-fetch | 减少手写 API Client |
| **API** | API Drift Check | OpenAPI Schema Check | OpenAPI Schema Check | CI 检查前后端 API 是否发生变化 |
| **Mock** | Mock API | MSW | MSW | 前端独立于后端开发 |
| **表单** | Form | react-hook-form | vee-validate / Composition API | 复杂业务表单建议使用 |
| **表单** | Schema Validation | Zod | Zod | 表单/API Runtime Validation |
| **状态** | Client State | useState / Context / Zustand | ref / reactive / Pinia | 不建议把 Server State 混进来 |
| **测试** | Unit Test | Vitest | Vitest | 与 Vite 配合 |
| **测试** | Component Test | React Testing Library | Vue Test Utils / Testing Library | UI Component 测试 |
| **测试** | API Mock Test | MSW | MSW | 测试和开发可共用 Handler |
| **测试** | E2E | Playwright | Playwright | 浏览器端 E2E |
| **质量** | Type Check | tsc | vue-tsc | CI 执行 |
| **质量** | Lint | ESLint | ESLint | 代码质量检查 |
| **质量** | Format | Prettier | Prettier | 代码格式化 |


# 后端项目技术选型 Checklist

| 分类 | 技术能力 | Java 方案 | Python 方案 | Rust 方案 | Node.js 方案 | 备注 |
|---|---|---|---|---|---|---|
| **基础** | Language | Java | Python | Rust | TypeScript | 建议统一运行时版本，并在 CI / Docker 中锁定 |
| **基础** | Framework | Spring Boot | FastAPI | Axum / Actix Web | NestJS / Fastify | 后端核心框架 |
| **基础** | Build Tool / Package Manager | Maven | uv | Cargo | pnpm | 依赖管理、Build、Test、Package |
| **数据库** | ORM / SQL Framework | MyBatis-Plus / jOOQ | SQLAlchemy / SQLModel | SQLx / SeaORM | Prisma / Drizzle ORM / TypeORM | 根据 CRUD / SQL 复杂度选择 |
| **数据库** | Database Migration | Flyway | Alembic | sqlx migrate / SeaORM Migration | Prisma Migrate / Drizzle Kit / TypeORM Migration | Schema 版本管理、Migration |
| **API** | API Contract | OpenAPI | OpenAPI | OpenAPI | OpenAPI | 作为前后端接口契约 |
| **API** | OpenAPI Generation | springdoc-openapi | FastAPI Built-in OpenAPI | utoipa / aide | NestJS Swagger / Fastify Swagger | 自动生成 OpenAPI |
| **API** | Swagger UI | springdoc-openapi Swagger UI | FastAPI Swagger UI | Swagger UI + utoipa | @nestjs/swagger / @fastify/swagger-ui | API 开发 / 调试 / 文档查看 |
| **API** | DTO / Schema Mapping | MapStruct | Pydantic | serde | class-transformer / Zod | DTO / Schema 转换 |
| **API** | Request Validation | Jakarta Bean Validation | Pydantic | validator / garde | class-validator / Zod | Request 参数校验 |
| **API** | Error Handling | `@ControllerAdvice` | Exception Handler | IntoResponse / custom error | NestJS Exception Filter / Error Middleware | 统一 API Error Response |
| **安全** | Authentication / Authorization | Spring Security | FastAPI Security / Authlib | tower / axum middleware | Passport / NestJS Guards / Middleware | 认证、授权、API Security |
| **安全** | Session | Spring Session JDBC | Redis / DB Session | tower-sessions / Redis | express-session / Redis | 有 Server Session 时使用 |
| **安全** | Permission Enforcement | Spring Security + AOP | Dependency / Decorator / Middleware | Middleware / Extractor | NestJS Guards / Decorators / Middleware | 统一权限控制 |
| **可观测性** | Health Check | Spring Boot Actuator | 自定义 `/health` / healthcheck library | 自定义 `/health` | @nestjs/terminus / 自定义 `/health` | 健康检查 |
| **可观测性** | Metrics | Actuator + Micrometer | Prometheus Client | metrics / prometheus crates | prom-client / OpenTelemetry | HTTP / DB / Runtime 等指标 |
| **可观测性** | Logging | SLF4J + Logback | structlog / logging | tracing | Pino / Winston | 结构化日志 |
| **测试** | Unit Test | JUnit 5 | pytest | cargo test | Vitest / Jest | 单元测试 |
| **测试** | Mock | Mockito | unittest.mock / pytest-mock | mockall | Vitest Mock / Jest Mock | 测试 Mock |
| **测试** | Integration Test | Spring Boot Test | pytest | cargo test | Supertest + Vitest / Jest | 集成测试 |
| **部署** | Container | Docker | Docker | Docker | Docker | 后端容器化部署 |
| **部署** | Configuration | Spring Profiles + Environment Variables | Environment Variables + Settings | Environment Variables + config | Environment Variables + config library | `local / test / staging / prod` 环境隔离 |

# Command Runner（命令运行器）

https://github.com/casey/just

https://github.com/casey/just/blob/master/README.%E4%B8%AD%E6%96%87.md

just 是一个专职 command runner（命令运行器）。

你可以把它理解成：把项目里那些常用但难记的命令，取一个简单名字，然后用 `just <名字>` 来执行。

它的定位和 make 有一点像，但 just 不是构建系统，它不关心文件依赖、增量编译、时间戳这些东西；它主要解决的是：项目命令太长、参数太多、团队成员记不住。

一个最小例子，项目根目录放一个 ``justfile``
```
# 查看所有可用命令
default:
    @just --list

# 启动开发环境
dev:
    npm run dev

# 跑测试
test:
    npm test

# 清理
clean:
    rm -rf dist
```

之后不需要记具体命令：
```bash
just dev
just test
just clean
```
