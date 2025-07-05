---
title: Markdown to PDF with Marp
allowed-tools: Read, Write, Bash(marp:*, rm:*)
description: Simplify markdown and convert to PDF with Marp
---

## Context
- Input file: $ARGUMENTS
- Guidelines: @~/.claude/templates/slide-guidelines.md
- Template: @~/.claude/templates/design-template.md

## Your task

1. Read the input markdown file
2. Read the slide guidelines
3. Simplify the markdown content according to the guidelines
4. Read the design template
5. Apply the template to the simplified content
6. Save to a temporary file
7. Convert to PDF using Marp CLI
8. Clean up the temporary file
