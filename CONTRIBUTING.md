# Contributing to BugBounty-Arsenal

Thanks for your interest in contributing! This toolkit grows stronger with every contribution from the bug bounty community.

## How to Contribute

### 1. Add New Test Cases

Each vulnerability category lives in `skills/hunting/<category>/SKILL.md`. To add a test case:

```markdown
## [CATEGORY-###] Test Name (difficulty)

1. Instruction on what to test and how.
   > What to report: What indicates a vulnerability.
```

- Follow the existing numbering scheme (check `skills/hunting/INDEX.md`)
- Assign difficulty: `(easy)`, `(medium)`, or `(hard)`
- Include what to report

### 2. Add New Vulnerability Categories

1. Create `skills/hunting/<new-category>/SKILL.md`
2. Follow the standard format:
   - Title with test count
   - Trigger line: `> Load when: [keywords]`
   - Numbered test cases with difficulty ratings
   - Reference tables where applicable
3. Update `skills/hunting/INDEX.md` with the new category
4. Update `README.md` vulnerability table

### 3. Improve Payloads

Add payloads to `skills/payloads/SKILL.md`:

```markdown
### [Type]
\`\`\`payload
your-payload-here
\`\`\`
```

### 4. Add Dorks

Add dorks to the appropriate file in `dorks/`:
- `google-dorks.md` — Google search dorks
- `github-dorks.md` — GitHub code search dorks
- `shodan-dorks.md` — Shodan IoT dorks

### 5. Add Tool Scripts

Place scripts in `tools/scripts/` and update `README.md` with usage instructions.

### 6. Improve AI Agents

Agents live in `agents/`. When editing:
- Maintain the trigger line format
- Keep instructions numbered and specific
- Include safety rules where applicable

## Quality Standards

- **Be specific** — "Test for XSS" is bad. "Test the search parameter for reflected XSS using event handlers on script-adjacent contexts" is good.
- **Include payloads** — Don't just say "try injection". Show the actual payloads.
- **Rate difficulty** — Every test case needs a difficulty rating.
- **Reference sources** — If your contribution is based on existing research, credit it.
- **No duplicates** — Check existing content before adding.

## File Format

### Skill Files (`SKILL.md`)

```markdown
# Category Name (N test cases)

> Load when: [trigger keywords that activate this skill]

1. **Test Name** (difficulty): Detailed instruction.
   > What to report: Description of what indicates a vulnerability.

2. **Test Name** (difficulty): Detailed instruction.
   > What to report: Description of what indicates a vulnerability.

## Reference

[Tables, payloads, cheat sheets]
```

### Agent Files

```markdown
# Agent Name

> Load when: [trigger keywords]

1. [Step-by-step instruction]
2. [Step-by-step instruction]
...
```

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b add-new-category`
3. Make your changes following the format above
4. Update INDEX.md if adding new categories
5. Update README.md if adding new features
6. Submit a pull request with a clear description

## Reporting Issues

Found a bug in the toolkit? Open an issue with:
- What's wrong
- Expected behavior
- How to fix (if you know)

## Code of Conduct

- Be respectful and constructive
- Focus on improving the toolkit for everyone
- No toxic behavior — we're all here to learn and hunt
