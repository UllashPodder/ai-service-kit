# AIServiceKit — Build Context

## What this is
Protocol-first Swift package for **on-device** speech transcription and
summarization. No cloud, no API keys, no data leaving the device.

Public, MIT-licensed. Built for and consumed by Debrief
(github.com/UllashPodder/debrief, private). This repo is also a
**portfolio piece** — public visibility, so code quality and docs are
held to a higher bar than throwaway app code.

## Audience for this repo
UK startup CTOs and consultancy hiring managers will read this code.
Every commit, README line, and API name is a hiring signal. Optimise for
clarity and senior judgment, not cleverness.

## Architecture
- `AIServiceKit`        — protocols only (AITranscriber, AISummarizer,
                          SummaryFormat). ZERO external dependencies. This
                          is deliberate — consumers can implement their own
                          backends against the protocols.
- `AIServiceKitWhisper` — AITranscriber backed by WhisperKit (on-device Whisper)
- `AIServiceKitMLX`     — AISummarizer backed by MLX + Llama 3.2 3B 4-bit

Consumers pick only the targets they need. Protocols target stays
dependency-free.

## Hard constraints
- iOS 18+ / macOS 14+
- Swift 6, strict concurrency, all public types Sendable-correct
- swift-tools-version: 6.0 (NOT higher — must resolve on older toolchains/CI)
- Every public symbol marked `public` with a doc comment (/// ...)
- No force-unwraps in public code paths

## Dependencies
- AIServiceKitWhisper → argmaxinc/WhisperKit
- AIServiceKitMLX → ml-explore/mlx-swift-examples (model:
  mlx-community/Llama-3.2-3B-Instruct-4bit, pinned to a revision hash)

## Done so far
- [x] Protocols defined (AITranscriber, AISummarizer, SummaryFormat)
- [x] Three-target package structure, public on GitHub, MIT
- [x] Package.swift at repo root, tools-version 6.0
- [x] WhisperKitTranscriber implementation
- [ ] MLXLlamaSummarizer implementation + SummaryPrompts

## Next (in order)
1. Implement MLXLlamaSummarizer (briefDescription first, then other 3 formats)
2. Implement WhisperKitTranscriber
3. Unit tests via Swift Testing for SummaryFormat + prompt building
4. Doc comments on every public symbol
5. README usage examples that match the ACTUAL API (no aspirational fiction)

## CLAUDE CODE RULES — read carefully, public repo
- NEVER run `git push` — Ullash reviews and pushes manually
- NEVER create pull requests or branches unless explicitly asked
- NEVER commit automatically — write code only
- When a task is done, stop and say "Ready for review. Run `git diff`."
- This is a PUBLIC repo. No secrets, no TODO-with-personal-notes, no
  commented-out dead code, no AI-generated filler in comments or README.
- Keep public API surface minimal. Don't add public symbols "just in case."

## Code standards (higher bar than the app)
- Doc comment (/// ...) on every public type, method, and property
- Prefer protocols + structs over classes
- Injectable dependencies via initialisers with sensible defaults
- No JSON parsing in V1 — summarizer returns raw String
- Prompt templates live in Sources/AIServiceKitMLX/Prompts/, injectable, testable
