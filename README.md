# Chatbox Flutter

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.10+-blue.svg" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Dart-3.0+-blue.svg" alt="Dart Version">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20macOS%20%7C%20Windows%20%7C%20Linux%20%7C%20Web-lightgrey.svg" alt="Platform">
</p>

一个功能完整的跨平台 AI 聊天应用，使用 Flutter 构建，支持多种 LLM 提供商、RAG 知识库、MCP 工具协议等高级功能。

## 功能特性

### 🤖 多模型支持
- **OpenAI** - GPT-4o, GPT-4, GPT-3.5-Turbo
- **Anthropic** - Claude 3.5 Sonnet, Claude 3 Opus/Haiku
- **Ollama** - 本地模型支持 (Llama, Mistral, Qwen 等)
- **Azure OpenAI** - 企业级部署
- **自定义 API** - 兼容 OpenAI 格式的任意端点

### 🔍 联网搜索
- **Tavily** - AI 优化的搜索引擎
- **Bing** - Microsoft Bing Web Search API
- **DuckDuckGo** - 无需 API Key 的免费搜索

### 📚 RAG 知识库
- 本地向量数据库 (ObjectBox)
- 支持 PDF, TXT, Markdown 等文档格式
- 自动文档分块与嵌入
- 语义相似度检索

### 🔌 MCP 工具协议
- 完整 MCP (Model Context Protocol) 客户端实现
- 支持 SSE / HTTP / STDIO 传输
- 动态工具发现与调用
- 与 LLM 无缝集成

### 🎨 用户界面
- Material Design 3 设计语言
- 深色/浅色/跟随系统主题
- 多语言支持 (中文/英文/日语)
- Markdown 渲染 + LaTeX 数学公式
- Mermaid 图表渲染
- HTML Artifacts 预览

### 💬 对话管理
- 多会话管理
- Copilots (自定义 AI 助手)
- 会话设置 (温度/Top-P/上下文长度)
- 消息编辑与重新生成
- 图片/文件附件支持

## 技术架构

```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                      │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │
│  │  Pages  │ │ Widgets │ │Providers│ │ Router  │           │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘           │
├─────────────────────────────────────────────────────────────┤
│                       Domain Layer                           │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │
│  │Entities │ │  Models │ │ Settings│ │ Configs │           │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘           │
├─────────────────────────────────────────────────────────────┤
│                        Data Layer                            │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐           │
│  │LLMService│ │RAGService│ │MCPService│ │SearchSvc│          │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘           │
├─────────────────────────────────────────────────────────────┤
│                      Storage Layer                           │
│  ┌─────────────────┐  ┌─────────────────┐                   │
│  │   Drift (SQL)   │  │ObjectBox (Vector)│                   │
│  └─────────────────┘  └─────────────────┘                   │
└─────────────────────────────────────────────────────────────┘
```

### 目录结构

```
lib/
├── app/                          # 应用入口
│   ├── app.dart                  # MaterialApp 配置
│   ├── router.dart               # GoRouter 路由
│   ├── shell_page.dart           # 底部导航
│   └── theme/                    # 主题配置
├── core/                         # 核心模块
│   ├── di/                       # 依赖注入
│   └── storage/                  # 存储层
│       ├── database/             # Drift SQLite
│       └── vector_store/         # ObjectBox 向量库
├── features/                     # 功能模块
│   ├── ai_models/                # AI 模型管理
│   │   ├── data/                 # LLM 服务
│   │   ├── domain/               # Provider 配置
│   │   └── presentation/         # 设置页面
│   ├── chat/                     # 聊天功能
│   │   ├── domain/               # 消息/会话实体
│   │   └── presentation/         # 聊天界面
│   ├── copilots/                 # AI 助手
│   ├── knowledge_base/           # RAG 知识库
│   │   ├── data/                 # Embedding/RAG 服务
│   │   └── presentation/         # 知识库管理
│   ├── mcp/                      # MCP 协议
│   │   ├── domain/               # MCP 配置模型
│   │   └── presentation/         # MCP 服务器管理
│   ├── settings/                 # 应用设置
│   └── tools/                    # 工具服务
│       └── data/engines/         # 搜索引擎实现
└── main.dart                     # 入口文件
```

### 核心依赖

| 类别 | 库 | 用途 |
|------|-----|------|
| 状态管理 | `flutter_riverpod` | 响应式状态管理 |
| 路由 | `go_router` | 声明式路由 |
| 数据库 | `drift` | SQLite ORM |
| 向量库 | `objectbox` | 本地向量存储 |
| LLM | `langchain_dart` | LLM 框架 |
| MCP | `mcp_client` | MCP 协议客户端 |
| 国际化 | `easy_localization` | i18n 支持 |
| 数据模型 | `freezed` | 不可变数据类 |

## 快速开始

### 环境要求

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.0.0
- Xcode 15+ (iOS/macOS)
- Android Studio (Android)

### 安装

```bash
# 克隆仓库
git clone https://github.com/helloandworlder/chatbox.git
cd chatbox

# 安装依赖
flutter pub get

# 生成代码 (Freezed/Drift/ObjectBox)
dart run build_runner build --delete-conflicting-outputs
```

### 运行

```bash
# iOS 模拟器
flutter run -d "iPhone 17 Pro"

# Android 模拟器
flutter run -d emulator-5554

# macOS
flutter run -d macos

# Web
flutter run -d chrome
```

### 开发调试

```bash
# 代码分析
flutter analyze

# 运行测试
flutter test

# 持续代码生成 (开发时)
dart run build_runner watch
```

## 打包发布

### iOS

```bash
# 构建 IPA
flutter build ipa --release

# 输出位置: build/ios/ipa/
```

### Android

```bash
# 构建 APK
flutter build apk --release

# 构建 App Bundle (Google Play)
flutter build appbundle --release

# 输出位置: build/app/outputs/
```

### macOS

```bash
flutter build macos --release
# 输出位置: build/macos/Build/Products/Release/
```

### Windows

```bash
flutter build windows --release
# 输出位置: build/windows/x64/runner/Release/
```

### Linux

```bash
flutter build linux --release
# 输出位置: build/linux/x64/release/bundle/
```

### Web

```bash
flutter build web --release
# 输出位置: build/web/
```

## 配置说明

### AI Provider 配置

在应用内 **设置 → AI 模型服务商** 添加:

| Provider | 必填项 |
|----------|--------|
| OpenAI | API Key |
| Anthropic | API Key |
| Azure OpenAI | Endpoint, API Key, Deployment |
| Ollama | Base URL (默认 http://localhost:11434) |

### MCP 服务器配置

在 **设置 → MCP 服务器** 添加:

**SSE 传输:**
```
URL: http://localhost:8999/sse
```

**HTTP 传输:**
```
URL: https://mcp-server.example.com
```

**STDIO 传输 (桌面端):**
```
Command: npx
Arguments: -y @modelcontextprotocol/server-filesystem /path/to/dir
```

### 搜索引擎配置

在 **设置 → 联网搜索** 配置:

- **Tavily**: 需要 API Key ([获取](https://tavily.com))
- **Bing**: 需要 Azure Bing Search API Key
- **DuckDuckGo**: 无需配置

## 维护指南

### 添加新的 AI Provider

1. 在 `lib/features/ai_models/domain/provider_config.dart` 添加类型:
```dart
enum AIProviderType {
  // ...existing
  newProvider,
}
```

2. 在 `lib/features/ai_models/data/llm_service.dart` 实现:
```dart
ChatModel _createNewProviderModel(AIProviderConfig config, String modelId) {
  // 实现 LangChain ChatModel
}
```

### 添加新的搜索引擎

1. 创建 `lib/features/tools/data/engines/new_engine.dart`:
```dart
class NewEngine implements SearchEngine {
  @override
  Future<List<SearchResult>> search(String query, {int maxResults = 5}) async {
    // 实现搜索逻辑
  }
}
```

2. 在 `SearchService` 中注册引擎。

### 添加新语言

1. 创建 `assets/translations/{lang_code}.json`
2. 在 `main.dart` 添加 `Locale('{lang_code}')`
3. 翻译所有键值

### 数据库迁移

修改 Drift 表结构后:

```bash
# 增加 schemaVersion
# 在 migration() 中添加迁移逻辑
dart run build_runner build
```

## 测试

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/features/chat/

# 生成覆盖率报告
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## 常见问题

### Q: ObjectBox 初始化失败?
确保已运行代码生成:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Q: iOS 构建失败?
```bash
cd ios && pod install && cd ..
flutter clean && flutter pub get
```

### Q: MCP 连接失败?
1. 检查服务器 URL 是否正确
2. 确认服务器已启动
3. 查看控制台日志定位错误

## 贡献指南

1. Fork 本仓库
2. 创建功能分支: `git checkout -b feature/amazing-feature`
3. 提交更改: `git commit -m 'feat: add amazing feature'`
4. 推送分支: `git push origin feature/amazing-feature`
5. 提交 Pull Request

## 许可证

MIT License - 详见 [LICENSE](LICENSE)

## 致谢

- [LangChain.dart](https://github.com/davidmigloz/langchain_dart) - LLM 框架
- [mcp_client](https://pub.dev/packages/mcp_client) - MCP 协议实现
- [Chatbox](https://github.com/nicepkg/chatbox) - 原始 TypeScript 版本

---

<p align="center">Made with ❤️ using Flutter</p>
