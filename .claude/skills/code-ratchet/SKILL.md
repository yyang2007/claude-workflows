---
name: code-ratchet
description: |
  棘轮循环协议。每次 Write/Edit 调用后自动执行 CHANGE → COMMIT → VERIFY → KEEP/ROLLBACK。
  触发条件：任何 Write 或 Edit 工具调用后立即触发。
---

# Code Ratchet Skill — 棘轮循环协议

## 优先级链（裁决顺序）
当规则冲突时，按以下优先级裁决：
- CRITICAL（最高）：安全、数据隐私、拒绝违规请求
- HIGH（高）：输出格式、必填字段约束
- MEDIUM（中）：内容质量规则、示例遵循
- LOW（低）：风格偏好、表达方式
- DISPOSABLE（可丢弃）：超出以上范围的一般建议


> 核心原则：代码库只能单调变好。每次修改必须经过「改 → 验证 → 过保留/不过回滚」的闭环。

---

## 棘轮循环（每次 Write/Edit 后强制执行）

```
FOR each Write/Edit call:
  1. CHANGE   — 单次只改 1-2 处逻辑，diff ≤200 行，≤2 文件
  2. COMMIT   — git add + git commit -m "snapshot: <what>"
  3. VERIFY   — 运行 verify.sh（或项目等价验证）
  4. KEEP     — exit 0 → 保留变更，进入下一轮
  5. ROLLBACK — exit ≠ 0 → git reset --hard HEAD~1，分析根因，重试
  
  同一变更回滚 ≥3 次 → 暂停，向用户报告根因分析。
```

---

## 五条铁律

### 1. 单次只改 1-2 处

- 一次 Edit 只修一个函数
- 一次 Write 只写一个新文件（≤200 行）
- 不在同一次调用里「顺手改点别的」
- 保证 diff 可读、可归因

### 2. 每次修改后自检

- 写完 → 立刻验证（不等用户提醒）
- 5 分钟墙钟预算内完成验证
- 不等、不攒

### 3. 北极星指标：verify.sh exit 0

- exit 0 → 保留
- exit ≠ 0 → 修，不往前推
- 不存在「测试红但我觉得没事，先继续」

### 4. 不改护栏文件

以下文件只读，必须改时多确认一次：
- `.claude/hooks/` 目录
- `.claude/settings.json` / `.claude/settings.local.json`
- `verify.sh`
- `progress.yaml`
- `.env` / `.env.*`

### 5. 失败 = 回滚，不攒着

- 验证失败 → 立刻回滚那步改动
- 不留着 3 个失败等后面一起修
- 代码库只能单调变好

---

## 约束作用域（四级权限）

| 级别 | 约束 | 示例文件 |
|------|------|---------|
| FORBIDDEN | 不可修改 | `.claude/hooks/*`, `verify.sh`, `.env` |
| RESTRICTED | 确认后才能改 | `.claude/settings.json`, `progress.yaml` |
| CAUTION | 可改但需验证 | 管线核心文件（orchestrator、stateMachine） |
| FREE | 自由修改 | 新建文件、测试文件、非核心工具函数 |

---

## 反模式（禁止项）

| 禁止 | 替代方案 |
|------|---------|
| 一次调用改 3+ 文件 | 拆成多次独立 Edit/Write |
| 攒 3 个变更一起验证 | 每个变更后立刻验证 |
| verify.sh 红但继续推 | 停下来修，不过不推 |
| 改护栏文件不改功能代码 | 先改功能代码，护栏只读 |
| 回滚 3 次还用同一方案 | 暂停，换思路，向用户报告 |

---

## Git 即记忆

- 每步 snapshot commit 是唯一的真相源
- 回滚 = `git reset --hard HEAD~1`（撤销上一步变更）
- 绝不 amend / rebase 已通过的 commit
- Commit message 格式：`snapshot: <改了什么>`



<!-- [AUTO-GENERATED] Paired example template -->
每条规则必须附带成对示例：

WRONG（反面示例）：
```
<不符合规则的错误做法>
```

RIGHT（正面示例）：
```
<符合规则的正确做法>
```

Rationale：<解释为什么 WRONG 错、RIGHT 对的理由>
## 系统自检（每次输出前跑一遍）
- [ ] 是否违反安全/拒绝规则？
- [ ] 规则冲突时是否按优先级链裁决？
- [ ] 是否有我无法执行的模糊指令？
- [ ] 输出格式是否完全符合模板要求？
- [ ] 用户没问的我是否主动建议了？（如果是不必要的，删除）
