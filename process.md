# Chatbox Flutter 迁移进度

基于 [flutter-migration-architecture.md](../docs/flutter-migration-architecture.md) 架构文档的实现进度。

---

## 总体进度

| 阶段 | 内容 | 状态 | 完成日期 |
|------|------|------|----------|
| **Phase 1** | 项目初始化 + Drift 数据库 | ✅ 完成 | 2024-11-29 |
| **Phase 2** | LangChain.dart + 流式响应 | ✅ 完成 | 2024-11-29 |
| **Phase 3** | MCP 协议 (mcp_client) | ✅ 完成 | 2024-11-29 |
| **Phase 4** | ObjectBox RAG + 知识库 | ✅ 完成 | 2025-11-29 |
| **Phase 5** | UI 完善 + 设置页面 | ✅ 完成 | 2025-11-29 |
| **Phase 6** | 测试 + 性能优化 | ✅ 完成 | 2025-11-29 |

---

## Phase 1: 项目初始化 + Drift 数据库 ✅

### 1.1 项目创建
- [x] 创建 Flutter 项目 (`flutter create chatbox_flutter --org com.chatboxapp`)
- [x] 配置 pubspec.yaml 依赖

### 1.2 依赖安装
```yaml
# 状态管理
flutter_riverpod: ^2.5.1
riverpod_annotation: ^2.3.5

# 数据库
drift: ^2.18.0
drift_flutter: ^0.1.0
sqlite3_flutter_libs: ^0.5.21

# 路由
go_router: ^14.2.0

# UI
flutter_markdown: ^0.7.1
flutter_highlight: ^0.7.0

# 数据模型
freezed_annotation: ^2.4.1
json_annotation: ^4.9.0
```

### 1.3 目录结构
```
lib/
├── main.dart
├── app/
│   ├── app.dart              # MaterialApp + Riverpod
│   ├── router.dart           # go_router 配置
│   ├── shell_page.dart       # 底部导航外壳
│   └── theme/
│       └── app_theme.dart    # Light/Dark 主题
├── core/
│   ├── di/
│   │   └── providers.dart    # 全局 Provider
│   └── storage/
│       └── database/
│           ├── app_database.dart      # Drift 数据库
│           └── tables/
│               ├── sessions_table.dart
│               ├── messages_table.dart
│               └── settings_table.dart
├── features/
│   ├── chat/
│   │   ├── domain/entities/
│   │   │   ├── session.dart
│   │   │   └── message.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── chat_provider.dart
│   │       ├── pages/
│   │       │   ├── chat_page.dart
│   │       │   └── session_list_page.dart
│   │       └── widgets/
│   │           ├── message_list.dart
│   │           ├── message_item.dart
│   │           └── input_box/
│   │               └── input_box.dart
│   └── settings/
│       └── presentation/pages/
│           └── settings_page.dart
└── shared/
```

### 1.4 数据库实现
- [x] Sessions 表 (会话管理)
- [x] Messages 表 (消息存储)
- [x] Settings 表 (设置存储)
- [x] 响应式查询 (watchAllSessions, watchMessages)
- [x] CRUD 操作

### 1.5 UI 骨架
- [x] 底部导航 (Chat / Copilots / Settings)
- [x] 聊天页面 (消息列表 + 输入框)
- [x] 会话列表页面 (侧滑抽屉)
- [x] 设置页面 (AI Providers / Appearance / Data)
- [x] Light/Dark 主题支持

### 1.6 验证
- [x] `flutter analyze` - 无错误
- [x] `flutter test` - 测试通过

---

## Phase 2: LangChain.dart + 流式响应 ✅

### 2.1 依赖添加
```yaml
# LLM 框架 (LangChain.dart)
langchain: ^0.7.6
langchain_openai: ^0.7.2      # OpenAI Chat Completions API
langchain_anthropic: ^0.1.1   # Claude 原生 Messages API
langchain_ollama: ^0.3.2      # 本地模型

# 网络请求
dio: ^5.4.3
```

**注意**: 
- `langchain_google` (google_generative_ai) 已废弃，Gemini 改用 OpenAI 兼容 API
- Claude 使用原生 `langchain_anthropic`，而非 OpenAI 兼容模式

### 2.2 目录结构
```
lib/features/ai_models/
├── domain/
│   └── provider_config.dart       # AI Provider 配置模型 (Freezed)
├── data/
│   ├── llm_service.dart           # LLM 服务封装
│   └── model_fetcher.dart         # 从 API 获取模型列表
└── presentation/
    ├── providers/
    │   └── ai_provider.dart       # Riverpod Provider
    └── pages/
        └── provider_settings_page.dart  # Provider 设置页面
```

### 2.3 实现内容
- [x] 添加 LangChain.dart 依赖
- [x] 实现 LLMService 封装
  - 统一的 Provider 注册接口
  - 流式响应 (streamChat)
  - 同步调用 (chat)

**内置提供商 (使用正确的 API 规范):**
| 提供商 | API 类型 | 实现方式 |
|--------|----------|----------|
| OpenAI | Chat Completions API | `langchain_openai` |
| Claude | 原生 Messages API | `langchain_anthropic` |
| Gemini | OpenAI 兼容 API | `langchain_openai` (base_url) |
| DeepSeek | OpenAI 兼容 API | `langchain_openai` (base_url) |
| OpenRouter | OpenAI 兼容 API | `langchain_openai` (base_url) |
| Ollama | 原生 API | `langchain_ollama` |
| Azure | OpenAI 兼容 API | `langchain_openai` (base_url) |

- [x] 流式响应处理
  - 实时更新 UI
  - 支持停止生成
- [x] 消息发送完整流程
  - 保存用户消息
  - 创建占位 AI 消息
  - 流式更新内容
  - 保存最终结果
  - 错误处理
- [x] 自动获取模型列表 (model_fetcher.dart)
  - OpenAI/DeepSeek/Gemini: `GET /v1/models`
  - OpenRouter: `GET /api/v1/models` (含元数据)
  - Ollama: `GET /api/tags` (本地模型)
  - Claude: 无 API，使用默认列表

### 2.4 UI 更新
- [x] ModelSelector 组件 (模型选择器)
- [x] InputBox 支持生成状态和停止按钮
- [x] MessageItem 支持流式内容显示
- [x] Provider 设置页面 (添加/编辑/删除 Provider)
- [x] Provider 刷新模型列表按钮
- [x] Settings 页面集成 Provider 管理入口

### 2.5 验证
- [x] `flutter analyze` - 无错误 (1 info 级别提示)
- [x] `flutter test` - 测试通过

---

## Phase 3: MCP 协议 (mcp_client) ✅

### 3.1 依赖添加
```yaml
# MCP 协议
mcp_client: ^1.0.2    # MCP 客户端 (STDIO/SSE/HTTP)
```

### 3.2 目录结构
```
lib/features/mcp/
├── domain/
│   └── mcp_config.dart              # MCP 服务器配置模型 (Freezed)
├── data/
│   └── mcp_service.dart             # MCP 服务封装
└── presentation/
    ├── providers/
    │   └── mcp_provider.dart        # Riverpod Providers
    ├── pages/
    │   └── mcp_settings_page.dart   # MCP 设置页面
    └── widgets/
        ├── mcp_status.dart          # 状态指示器
        └── mcp_server_card.dart     # 服务器卡片 + 配置对话框
```

### 3.3 实现内容
- [x] 添加 mcp_client 依赖
- [x] MCP 数据模型 (Freezed)
  - `MCPServerConfig` - 服务器配置
  - `MCPTransportConfig` (sealed class) - STDIO/HTTP/SSE 传输配置
  - `MCPServerStatus` - 服务器状态
  - `MCPToolInfo` - 工具信息
- [x] 数据库表 (Drift)
  - `McpServers` 表 - 存储 MCP 服务器配置
  - Schema 升级迁移 (v1 → v2)
- [x] MCPService 核心服务
  - 启动/停止服务器
  - 多服务器管理
  - 状态流 (StreamController)
  - 工具列表获取
  - 工具调用接口
  - 平台检测 (STDIO 仅桌面端可用)
- [x] Riverpod Providers
  - `mcpServiceProvider` - MCP 服务实例
  - `mcpServersProvider` - 服务器配置列表 (响应式)
  - `mcpStatusesProvider` - 服务器状态流
  - `mcpActionsProvider` - 操作接口 (CRUD)
- [x] MCP 设置页面
  - 服务器列表展示
  - 添加/编辑/删除服务器
  - 启用/禁用开关
  - 实时状态显示
  - 工具列表查看
  - 平台提示 (移动端无法使用 STDIO)
- [x] 状态指示器 Widget
  - 动态颜色 (idle/starting/running/stopping/error)
  - 脉冲动画
  - 错误 Tooltip
- [x] InputBox 集成
  - MCP 聚合状态显示
  - 点击跳转 MCP 设置
- [x] 应用启动时自动启动已启用的服务器

### 3.4 Transport 支持
| Transport | 平台支持 | 说明 |
|-----------|----------|------|
| HTTP | 全平台 | StreamableHTTP 传输 |
| SSE | 全平台 | Server-Sent Events |
| STDIO | 仅桌面端 | 本地进程通信 |

### 3.5 验证
- [x] `flutter analyze` - 无错误
- [x] `flutter test` - 测试通过

### 3.6 后续优化 (可选)
- [ ] LLM 工具调用深度集成 (Agent 模式)
- [ ] 工具调用结果在消息中显示
- [ ] 自动重连机制

---

## Phase 4: ObjectBox RAG + 知识库 ✅

### 4.1 依赖添加
```yaml
# 向量数据库 (ObjectBox RAG)
objectbox: ^4.0.3
objectbox_flutter_libs: ^4.0.3
objectbox_generator: ^4.0.3  # dev dependency

# 工具类
file_picker: ^8.0.3
path: ^1.9.0
```

### 4.2 目录结构
```
lib/features/knowledge_base/
├── domain/
│   └── knowledge_base.dart          # 实体模型 (Freezed)
├── data/
│   ├── models/
│   │   └── document_chunk.dart      # ObjectBox 向量模型
│   ├── embedding_service.dart       # OpenAI Embeddings API
│   └── rag_service.dart             # 向量搜索 + 文档分块
└── presentation/
    ├── providers/
    │   └── knowledge_base_provider.dart  # Riverpod Providers
    ├── pages/
    │   ├── knowledge_base_list_page.dart # 知识库列表
    │   └── knowledge_base_detail_page.dart # 文件管理
    └── widgets/
        ├── knowledge_base_card.dart      # 知识库卡片
        ├── file_card.dart                # 文件卡片
        └── knowledge_base_selector.dart  # 聊天中的选择器

lib/core/storage/
├── database/tables/
│   ├── knowledge_bases_table.dart       # Drift 知识库表
│   └── knowledge_base_files_table.dart  # Drift 文件表
└── vector_store/
    └── objectbox_store.dart             # ObjectBox 单例
```

### 4.3 数据库表 (Drift)
- [x] `KnowledgeBases` 表 - 知识库元数据
  - id, name, description
  - indexStatus, indexError
  - fileCount, chunkCount
  - embeddingDimensions, embeddingProviderId, embeddingModel
- [x] `KnowledgeBaseFiles` 表 - 知识库文件
  - id, knowledgeBaseId, fileName, filePath
  - mimeType, fileSize
  - indexStatus, indexError, chunkCount
- [x] Schema 升级迁移 (v2 → v3)

### 4.4 向量模型 (ObjectBox)
- [x] `DocumentChunk` - 1536 维向量 (OpenAI text-embedding-3-small)
- [x] `DocumentChunkLarge` - 3072 维向量 (OpenAI text-embedding-3-large)
- [x] HNSW 向量索引

### 4.5 核心服务
**EmbeddingService:**
- [x] OpenAI Embeddings API 封装
- [x] 单个/批量 embedding 生成
- [x] 可配置 model, baseUrl, dimensions
- [x] 从 AI Provider 快速配置

**RAGService:**
- [x] 文件读取 (txt, md, json, csv, xml, html)
- [x] 智能文本分块 (可配置 chunkSize, overlap)
- [x] 余弦相似度向量搜索
- [x] 单个/多个知识库搜索
- [x] 分数阈值过滤

### 4.6 Riverpod Providers
- [x] `objectBoxStoreProvider` - ObjectBox 实例
- [x] `embeddingServiceProvider` - Embedding 服务
- [x] `ragServiceProvider` - RAG 服务
- [x] `knowledgeBasesProvider` - 知识库列表 (响应式)
- [x] `knowledgeBaseFilesProvider` - 文件列表 (响应式)
- [x] `selectedKnowledgeBaseIdsProvider` - 聊天中选中的知识库
- [x] `embeddingConfigProvider` - Embedding 配置
- [x] `knowledgeBaseActionsProvider` - CRUD 操作

### 4.7 UI 实现
**知识库列表页面:**
- [x] 空状态引导
- [x] 知识库卡片 (状态、文件数、块数)
- [x] 创建/删除知识库
- [x] Embedding 设置对话框
- [x] 从 AI Provider 快速配置

**知识库详情页面:**
- [x] 文件列表
- [x] 添加文件 (file_picker)
- [x] 索引进度显示
- [x] 索引/重新索引文件
- [x] 删除文件
- [x] 编辑知识库名称/描述

**聊天集成:**
- [x] KnowledgeBaseSelector 组件
- [x] 多知识库选择
- [x] RAG 上下文注入
- [x] Settings 页面知识库入口

### 4.8 RAG 查询流程
```
用户问题 → sendMessage()
    │
    ├─→ 1. 检测选中的知识库
    │
    ├─→ 2. EmbeddingService.embed(query)
    │       └─→ OpenAI Embeddings API
    │
    ├─→ 3. RAGService.searchMultiple()
    │       └─→ 余弦相似度 top-k 搜索
    │
    ├─→ 4. 构建上下文
    │       └─→ [Knowledge Base Context]
    │           --- From file1.txt ---
    │           chunk content...
    │           [End of Context]
    │
    └─→ 5. 注入到用户消息 → LLM 调用
```

### 4.9 验证
- [x] `flutter analyze` - 无错误 (2 info 级别提示)
- [x] `flutter test` - 测试通过

### 4.10 后续优化 (可选)
- [ ] PDF/Word 文档解析
- [ ] 搜索结果在消息中显示来源
- [ ] 向量搜索性能优化 (ObjectBox HNSW 原生 API)
- [ ] 增量索引支持

---

## Phase 5: UI 完善 + 设置页面 ✅

### 5.1 依赖添加
```yaml
# UI 增强
highlight: ^0.7.0
markdown: ^7.2.2
flutter_math_fork: ^0.7.2
photo_view: ^0.14.0
share_plus: ^9.0.0

# 工具类
image_picker: ^1.1.0
url_launcher: ^6.2.6
```

### 5.2 目录结构
```
lib/features/
├── chat/presentation/widgets/
│   ├── markdown/
│   │   └── markdown_renderer.dart    # 增强 Markdown 渲染
│   ├── message_item.dart             # 支持图片/文件附件显示
│   └── input_box/
│       ├── attachment_picker.dart    # 附件选择器
│       └── input_box.dart            # 支持附件发送
└── settings/
    ├── data/
    │   └── data_service.dart         # 数据导入/导出服务
    └── presentation/pages/
        └── settings_page.dart        # 完善设置页面
```

### 5.3 实现内容

**Markdown 渲染增强:**
- [x] 代码高亮 (highlight.js 主题)
- [x] 语言标签显示
- [x] 一键复制代码
- [x] LaTeX 公式渲染 (flutter_math_fork)
- [x] 行内公式 `$...$`
- [x] 块级公式 `$$...$$`
- [x] 链接可点击打开

**图片/文件附件支持:**
- [x] AttachmentPicker 组件
  - 拍照 (ImageSource.camera)
  - 选图 (ImageSource.gallery, 支持多选)
  - 选文件 (FilePicker)
- [x] AttachmentPreview 缩略图预览
- [x] 图片 base64 编码发送
- [x] MessageItem 图片/文件显示
- [x] PhotoView 全屏查看图片

**模型选择器:**
- [x] Provider 分组显示
- [x] 模型上下文窗口显示
- [x] 当前选中状态标记

**AI Provider 设置页面:**
- [x] 添加/编辑/删除 Provider
- [x] API Key 安全掩码显示
- [x] 刷新模型列表
- [x] 启用/禁用开关

**数据导入/导出:**
- [x] DataExportService - 导出会话、消息、设置
- [x] DataImportService - 从 JSON 文件导入
- [x] Share 分享导出文件
- [x] 清除所有数据 (双重确认)

### 5.4 验证
- [x] `flutter analyze` - No issues found!
- [x] `flutter test` - All tests passed!

---

## Phase 6: 测试 + 性能优化 ✅

### 6.1 单元测试
- [x] LLM Service 测试 (`test/features/ai_models/llm_service_test.dart`)
  - Provider 注册/注销
  - 多 Provider 支持 (OpenAI, Claude, Gemini, DeepSeek, Ollama)
  - 模型访问
  - 异常处理
  - ChatChunk 和消息转换
  - AIProviderConfig / ModelConfig 序列化
  - 默认配置验证

- [x] Embedding Service 测试 (`test/features/knowledge_base/embedding_service_test.dart`)
  - 配置管理
  - API 请求构建
  - 响应解析
  - 批量处理逻辑

- [x] RAG Service 测试 (`test/features/knowledge_base/rag_service_test.dart`)
  - 文本分块算法
  - 余弦相似度计算
  - 文件读取
  - SearchResult 模型

- [x] Knowledge Base 实体测试 (`test/features/knowledge_base/knowledge_base_test.dart`)
  - KnowledgeBaseEntity 创建和序列化
  - KnowledgeBaseFileEntity 创建和序列化
  - SearchResult 排序和过滤
  - 索引状态管理

### 6.2 Widget 测试
- [x] 附件选择器测试 (`test/features/chat/attachment_picker_test.dart`)
  - Attachment 模型
  - MIME 类型检测
  - 图片文件识别
  - AttachmentPreview 渲染
  - AttachmentMenuSheet 交互

- [x] 模型选择器测试 (`test/features/chat/model_selector_test.dart`)
  - Provider 配置验证
  - Provider 查找逻辑
  - 模型过滤
  - Provider 图标映射
  - 数字格式化

### 6.3 集成测试
- [x] 聊天功能集成测试 (`test/integration/chat_integration_test.dart`)
  - LLM Service + Provider Config 生命周期
  - 多 Provider 共存
  - Provider 序列化/反序列化
  - Embedding Service 配置
  - 消息内容处理 (文本/图片/文件)
  - RAG 上下文注入
  - 消息转换
  - 会话名称生成

### 6.4 测试覆盖范围
| 模块 | 测试文件 | 测试数量 |
|------|----------|----------|
| LLM Service | llm_service_test.dart | 31 |
| Embedding Service | embedding_service_test.dart | 17 |
| RAG Service | rag_service_test.dart | 19 |
| Knowledge Base | knowledge_base_test.dart | 17 |
| Attachment Picker | attachment_picker_test.dart | 49 |
| Model Selector | model_selector_test.dart | 12 |
| Chat Integration | chat_integration_test.dart | 19 |
| **总计** | **7 个测试文件** | **164 个测试** |

### 6.5 验证
- [x] `flutter test` - 所有 164 个测试通过

### 6.6 后续优化 (可选)
- [ ] 性能分析
- [ ] 内存优化
- [ ] 端到端测试 (需要真实 API)

---

## 运行项目

```bash
cd chatbox_flutter

# 安装依赖
flutter pub get

# 代码生成 (Drift, Freezed)
dart run build_runner build --delete-conflicting-outputs

# 运行
flutter run
```

---

## 补充功能: Copilots (AI 助手角色) ✅

### 功能说明
Copilot 是预设的 AI 助手角色，每个 Copilot 包含名称、头像和系统提示词 (prompt)。选择 Copilot 后，其 prompt 会作为 system message 注入到对话中。

### 实现内容

**数据层:**
- [x] `Copilots` 数据库表 (Drift)
- [x] `CopilotEntity` Freezed 实体
- [x] 数据库迁移 v3 → v4

**状态管理:**
- [x] `copilotsProvider` - Copilots 列表 (响应式)
- [x] `copilotByIdProvider` - 按 ID 获取 Copilot
- [x] `copilotActionsProvider` - CRUD 操作

**UI 组件:**
- [x] `CopilotsPage` - Copilots 管理页面
- [x] `CopilotCard` - Copilot 卡片组件
- [x] `CopilotForm` - 创建/编辑表单
- [x] `CopilotPicker` - 聊天页 Copilot 选择器
- [x] `SelectedCopilotBanner` - 已选 Copilot 横幅

**聊天集成:**
- [x] 会话关联 Copilot (`session.copilotId`)
- [x] 发送消息时注入 system prompt
- [x] 聊天页面显示当前 Copilot

### 目录结构
```
lib/features/copilots/
├── domain/
│   └── copilot.dart              # Freezed 实体
└── presentation/
    ├── providers/
    │   └── copilot_provider.dart # Riverpod Providers
    ├── pages/
    │   └── copilots_page.dart    # Copilots 列表页
    └── widgets/
        ├── copilot_card.dart     # Copilot 卡片
        ├── copilot_form.dart     # 创建/编辑表单
        └── copilot_picker.dart   # 聊天中的选择器
```

### 验证
- [x] `flutter analyze` - 无错误
- [x] `flutter test` - 所有 164 个测试通过

---

---

## Phase 7: i18n + 设置分组 + AI 功能增强 + 渲染增强 (进行中)

### 7.1 国际化 (easy_localization) ✅

**依赖添加:**
```yaml
easy_localization: ^3.0.7
flutter_inappwebview: ^6.0.0  # Mermaid/Artifacts 渲染
```

**翻译文件:**
```
assets/translations/
├── zh.json    # 中文
├── en.json    # 英文
└── ja.json    # 日语
```

**实现内容:**
- [x] 添加 easy_localization 依赖
- [x] 创建三语翻译 JSON 文件
- [x] 初始化 main.dart 和 app.dart
- [x] AppSettings 添加 locale 设置
- [ ] 替换所有 UI 硬编码字符串 (进行中)

### 7.2 设置页面分组重构 ✅

**新增设置子页面:**
```
lib/features/settings/presentation/pages/
├── settings_page.dart              # 主入口 (分组导航)
├── model_settings_page.dart        # 模型设置
├── web_search_settings_page.dart   # 联网搜索设置
├── chat_settings_page.dart         # 对话设置 (显示+功能)
├── appearance_settings_page.dart   # 外观设置 (头像/主题/语言)
└── data_settings_page.dart         # 数据管理
```

**设置结构:**
- 🤖 模型设置 (默认对话/命名/搜索/OCR 模型)
- 🔌 AI Providers
- 🔍 联网搜索 (Tavily/Bing/DuckDuckGo)
- 💬 对话设置 (显示+功能选项)
- 🎨 外观设置 (主题/语言/头像)
- 🧩 MCP Servers
- 📚 Knowledge Bases
- 💾 数据管理
- ℹ️ 关于

### 7.3 Web Search 引擎扩展 ✅

**新增搜索引擎:**
```
lib/features/tools/data/engines/
├── search_engine.dart       # 抽象接口
├── tavily_engine.dart       # Tavily
├── bing_engine.dart         # Bing Web Search API
└── duckduckgo_engine.dart   # DuckDuckGo Instant Answer API
```

**AppSettings 扩展:**
- searchProvider: 'tavily' | 'bing' | 'duckduckgo'
- tavilyApiKey, bingApiKey
- tavilySearchDepth, searchMaxResults

### 7.4 Mermaid 图表渲染 ✅

**实现:**
```dart
// lib/features/chat/presentation/widgets/markdown/mermaid_renderer.dart
class MermaidRenderer extends StatefulWidget {
  final String code;
  // 使用 InAppWebView + mermaid.js CDN 渲染
}
```

**集成:**
- 检测 ```mermaid 代码块
- 自动替换为 MermaidRenderer Widget
- 支持浅色/深色主题

### 7.5 Artifacts HTML 预览 ✅

**实现:**
```dart
// lib/features/chat/presentation/widgets/markdown/artifact_preview.dart
class ArtifactPreview extends StatefulWidget {
  final String htmlContent;
  // InAppWebView 渲染 + Tailwind CSS CDN
}
```

**功能:**
- 检测 ```html 或 ```artifact 代码块
- 可折叠预览面板
- 支持全屏预览
- 一键复制 HTML

### 7.6 验证
- [x] `flutter analyze` - 通过 (仅 5 个测试文件 unused_import 警告)
- [x] `flutter test` - 所有 164 个测试通过

---

**最后更新**: 2025-11-30 (Phase 7 完成)
