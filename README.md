#⚙️ AI Service Kit

> A comprehensive Swift framework for seamlessly integrating AI services into your iOS, macOS, and cross-platform applications.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-5.0+-orange?logo=swift)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20watchOS-blue)](#)

## ✨ Features

- 🤖 **Unified AI Interface** - Single API for multiple AI service providers
- 🔌 **Plugin Architecture** - Extensible design for custom implementations
- 🛡️ **Type-Safe** - Full Swift type safety with modern async/await support
- ⚡ **Lightweight** - Minimal dependencies for maximum flexibility
- 🔄 **Request Caching** - Built-in caching layer for optimized performance
- 🧪 **Testable** - Mock implementations for easy unit testing
- 📱 **Cross-Platform** - Support for iOS, macOS, watchOS, and tvOS
- 🔐 **Secure** - Credential management best practices

## 🎯 Quick Start

### Installation

#### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/UllashPodder/ai-service-kit.git", from: "0.1.0")
]
```

Or in Xcode:
1. File → Add Packages
2. Enter: `https://github.com/UllashPodder/ai-service-kit.git`
3. Select version and add to your project

### Basic Usage

```swift
import AIServiceKit

// Initialize the AI Service Kit
let aiService = AIServiceKit.shared

// Make a simple request
let response = try await aiService.chat(
    message: "What is Swift?",
    provider: .openAI
)

print(response.text)
```

## 📚 Documentation

### Supported Providers

- OpenAI (GPT-4, GPT-3.5-turbo)
- Google Gemini
- Anthropic Claude
- Local LLM Models

### Configuration

```swift
// Configure with your API credentials
let config = AIServiceConfiguration(
    apiKey: "your-api-key",
    baseURL: URL(string: "https://api.openai.com/v1")!
)

aiService.configure(with: config)
```

### Advanced Usage

```swift
// Stream responses
for try await chunk in aiService.stream(prompt: "Write a poem") {
    print(chunk)
}

// Use embeddings
let embeddings = try await aiService.embed(text: "Hello, World!")

// Vision capabilities
let analysis = try await aiService.analyzeImage(imageURL, question: "What's in this image?")
```

## 🏗️ Project Structure

```
AIServiceKit/
├── Core/              # Core framework code
├── Providers/         # AI service provider implementations
├── Models/            # Data models and types
├── Utils/             # Utility functions and helpers
└── Tests/             # Test suite
```

## 🔧 Requirements

- **iOS** 13.0+
- **macOS** 10.15+
- **watchOS** 6.0+
- **tvOS** 13.0+
- **Swift** 5.7+

## 💡 Examples

Check out the [Examples](./Examples) directory for complete sample projects:

- Chat Application
- Image Analysis
- Embedding Generation
- Streaming Responses
- Error Handling

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

```bash
git clone https://github.com/UllashPodder/ai-service-kit.git
cd ai-service-kit
swift build
swift test
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋 Support

- 📖 [Documentation](./docs)
- 🐛 [Report Issues](https://github.com/UllashPodder/ai-service-kit/issues)
- 💬 [Discussions](https://github.com/UllashPodder/ai-service-kit/discussions)

## 🚀 Roadmap

- [ ] Support for more AI providers
- [ ] Advanced caching strategies
- [ ] Performance monitoring and analytics
- [ ] Rate limiting and throttling
- [ ] Offline mode support
- [ ] Enhanced error recovery

## ⭐ Show Your Support

If you find this project helpful, please consider giving it a star! Your support motivates continued development and improvement.

---

**Made with ❤️ by [UllashPodder](https://github.com/UllashPodder)**
