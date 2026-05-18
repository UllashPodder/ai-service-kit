## ⚙️ AI Service Kit

> Protocol-first Swift package for **on-device** speech transcription and summarization. No cloud, no API keys, no data leaving the device.

Built for [Debrief](https://github.com/UllashPodder/debrief) — a local-first
AI voice notes app for iOS.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-5.0+-orange?logo=swift)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20watchOS-blue)](#)

## Why

Cloud AI for voice notes means latency, per-token cost, and privacy risk.
This package abstracts on-device ASR and LLM summarization behind clean
protocols so the app never touches a vendor SDK directly.

## Architecture

- `AIServiceKit` — protocols only (`AITranscriber`, `AISummarizer`), zero dependencies
- `AIServiceKitWhisper` — `AITranscriber` backed by WhisperKit (on-device Whisper)
- `AIServiceKitMLX` — `AISummarizer` backed by MLX + Llama 3.2 3B (on-device LLM)

Pick only the targets you need. The protocols target stays dependency-free
so you can implement your own backend.

## Requirements

- iOS 18+ / macOS 14+
- Swift 6

## Status

🚧 Active development — V1 in progress (week 1 of 3). API will change.



## 🎯 Quick Start

## Install

​```swift
.package(url: "https://github.com/UllashPodder/ai-service-kit.git", from: "0.0.1")
​```

## License

MIT — see [LICENSE](LICENSE).


## 🙋 Support

- 🐛 [Report Issues](https://github.com/UllashPodder/ai-service-kit/issues)
- 💬 [Discussions](https://github.com/UllashPodder/ai-service-kit/discussions)


## ⭐ Show Your Support

If you find this project helpful, please consider giving it a star! Your support motivates continued development and improvement.

---

**Made with ❤️ by [UllashPodder](https://github.com/UllashPodder)**
