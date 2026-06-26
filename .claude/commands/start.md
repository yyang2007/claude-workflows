# 工作流选择

你当前想做什么？回复编号，我引导你走对应流程：

```
 1. 新功能     → /code-prep → /opsx:propose → /matt-tdd → /opsx:archive
                [planner 规划 → TDD 测试先行 → code-review 质量门]

 2. 修 Bug     → /matt-diagnose
                [codegraph 查调用链 → 写失败测试 → 修复 → 验证 → code-review]

 3. 改已有代码  → 直接改（code-ratchet 自动兜底）
                [改完自动 lint + type-check + code-review]

 4. 重构       → /matt-tdd + code-ratchet
                [codegraph 分析影响 → TDD 覆盖 → 审查]

 5. 小改动     → 直接改
                [hooks 自动校验格式和类型]

 6. 安全审查   → /security-scan
                [OWASP 顶十 + 敏感信息扫描]

 7. 代码审查   → /code-review
                [已有变更的独立审查]

 8. 部署       → bun run build → 部署
                [构建 + 发布]

 9. 知识库更新  → scripts/ingest.py → lint 校验
                [数据摄入 → 知识库校验]

10. 数据库迁移  → prisma migrate
                [Schema 变更 → 迁移 → 生成]
```

回复编号，我带你一步步走完。
