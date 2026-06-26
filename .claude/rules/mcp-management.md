# MCP 管理（ECC 指南）

依据 ECC shortform guide + README.zh-CN 的 MCP 管理原则：

## 三原则

1. **全局池 20-30 个**，项目启用 ≤10 个
2. **每个 MCP 有明确用途**，不装彩灯
3. **上下文窗口 > MCP 数量**，工具太多会压缩有效上下文

## 实际操作

```
~/.claude.json (mcpServers) → 全局候选池
project config (disabledMcpServers) → 项目级启用/禁用
```

加新 MCP 前先问：真的需要吗？有没有 CLI 替代？
