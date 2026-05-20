import AIServiceKit
import WhisperKit
import Foundation

public final actor WhisperKitTranscriber: AITranscriber {
    private let pipe: WhisperKit

    public init(model: String = "openai_whisper-base") async throws {
        self.pipe = try await WhisperKit(model: model)
    }

    public func transcribe(audioFileURL: URL) async throws -> String {
        let results = try await pipe.transcribe(audioPath: audioFileURL.path)
        return results.map(\.text).joined(separator: " ").trimmingCharacters(in: .whitespaces)
    }
}
