# code-prep skill

编码前准备流程。先追问需求 → 统一术语 → 输出 PRD → 拆解成可执行的 Issue。

## 安装

在目标项目的 `.claude/skills/` 下：

```bash
mkdir -p /path/to/your-project/.claude/skills/code-prep
cp SKILL.md /path/to/your-project/.claude/skills/code-prep/SKILL.md
```

## 使用

```
/code-prep                   完整流程（Phase 1→2→3）
/code-prep phase=2           从术语对齐开始（跳过追问）
/code-prep phase=3           从 PRD 开始
/code-prep quick             快速模式
```

## 依赖

无。纯 Markdown，零依赖。
