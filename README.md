# LS Transcoder - High-Performance AI Gateway / 高性能 AI 智能调度网关

[English Guide](#english-guide) | [中文说明](#中文部署手册)

---

## English Guide

This guide is for users deploying via the pre-compiled binary package (`ls-transcoder-v1.0.0-*.tar.gz`).

### 📦 Package Structure
- `cli-server`: Core Rust backend (Architecture specific)
- `apps/web-dashboard/dist/`: Interactive API Dashboard assets
- `extract_official_ls.sh`: Official core extractor tool
- `Dockerfile.binary` & `docker-compose.yml`: Container configurations

### 💻 Multi-Arch Support
- **x64 Hosts**: Use `linux-x64` bundle.
- **ARM64 Hosts**: Use `linux-arm64` bundle (e.g., Oracle ARM, RPi).

### 🚀 Quick Start
1. **Extract Core**: Run `bash extract_official_ls.sh` and move `core-bin/*` to `bin/`.
2. **Launch**: Run `docker-compose up -d`.
3. **Access**: Open `http://your-ip:3000` for the Interactive API Docs.

### 🛠️ Full API Reference

| Group | Method | Path | Description |
| :--- | :--- | :--- | :--- |
| **Core** | POST | `/v1/chat/completions` | OpenAI compatible chat (gpt-4o, etc.) |
| | POST | `/v1/messages` | Anthropic compatible (claude-3-5, etc.) |
| | POST | `/v1beta/models/:model:generateContent` | Gemini native compatibility |
| **Auth** | GET | `/v1/auth/login` | Initiate Google OAuth login |
| | GET/POST | `/v1/auth/callback_url` | **[Manual Fix]** Parse failed OAuth callback URL |
| | GET/POST | `/v1/accounts/import` | **[Direct Import]** Import via Refresh Token |
| | POST | `/v1/refresh_token` | Base Refresh Token interface |
| **Account** | GET | `/v1/accounts` | List accounts and quotas |
| | DELETE | `/v1/accounts/:id` | Unbind and delete account |
| | GET | `/v1/models` | List all active models |
| **System** | GET | `/v1/logs` | Fetch real-time logs |
| | GET | `/v1/keys` | List virtual API keys |
| | POST | `/v1/keys` | Issue new virtual keys |

### 🌐 Public Server OAuth Fix
If the redirect to `localhost` fails on a public server:
1. Copy the failed URL from your browser address bar.
2. Visit: `http://your-ip:3000/v1/auth/callback_url?url=PASTE_URL_HERE`

---

## 中文部署手册

此文档适用于使用预编译二进制压缩包 (`ls-transcoder-v1.0.0-*.tar.gz`) 进行部署的用户。

### 📦 目录结构
解压后您将看到以下内容：
- `cli-server`: Rust 核心后端 (需与架构匹配)
- `apps/web-dashboard/dist/`: 交互式 API 开发库静态资源
- `extract_official_ls.sh`: 官方核心提取脚本
- `Dockerfile.binary` & `docker-compose.yml`: 容器化配置

### 💻 多架构支持 (x64 / ARM)
- **x64 主机**: 请使用 `linux-x64` 压缩包。
- **ARM64 主机**: 请使用 `linux-arm64` 压缩包。

### 🚀 部署步骤
1. **提取核心**: 运行 `bash extract_official_ls.sh` 并将 `core-bin/*` 移动到 `bin/`。
2. **启动服务**: 运行 `docker-compose up -d`。
3. **访问后台**: 访问 `http://your-ip:3000` 查看交互式 API 文档。

### 🛠️ 全量 API 接口参考

| 分组 | 方法 | 路径 | 功能描述 |
| :--- | :--- | :--- | :--- |
| **核心转码** | POST | `/v1/chat/completions` | OpenAI 兼容聊天接口 (gpt-4o, etc.) |
| | POST | `/v1/messages` | Anthropic 兼容消息接口 (claude-3-5, etc.) |
| | POST | `/v1beta/models/:model:generateContent` | Gemini 原生兼容接口 |
| **鉴权认证** | GET | `/v1/auth/login` | 唤起 Google OAuth 授权页面 |
| | GET/POST | `/v1/auth/callback_url` | **[手动修复]** 解析 OAuth 回调链接 |
| | GET/POST | `/v1/accounts/import` | **[直接导入]** 通过 Refresh Token 导入账号 |
| | POST | `/v1/refresh_token` | 基础 Token 刷新接口 |
| **账号与配额** | GET | `/v1/accounts` | 列出已绑定账号与当前配额 |
| | DELETE | `/v1/accounts/:id` | 物理移除并解绑账号 |
| | GET | `/v1/models` | 获取当前全部可用存活模型 |
| **系统监控** | GET | `/v1/logs` | 获取实时运行日志 |
| | GET | `/v1/keys` | 列出安全虚拟调用凭证池 |
| | POST | `/v1/keys` | 随机签发业务虚拟 Key |

### 🌐 公网 OAuth 解决方案
如果公网授权跳转 `localhost` 报错，请复制报错链接并访问：
`http://your-ip:3000/v1/auth/callback_url?url=报错链接`
