import AIServiceKit
import WhisperKit
import Foundation

/// Errors thrown by ``WhisperKitTranscriber``.
public enum WhisperKitTranscriberError: Error {
    /// The audio contained no recognisable speech after cleaning special tokens.
    case noSpeechDetected
}

/// On-device transcriber backed by WhisperKit.
///
/// Strips Whisper's non-speech markers (`[BLANK_AUDIO]`, `[MUSIC]`, etc.) and
/// control tokens (`<|endoftext|>`, timestamps) before returning the transcript.
/// Throws ``WhisperKitTranscriberError/noSpeechDetected`` if nothing remains.
///
/// ## Usage
/// ```swift
/// let transcriber = try await WhisperKitTranscriber()
/// let transcript = try await transcriber.transcribe(audioFileURL: url)
/// ```
public final actor WhisperKitTranscriber: AITranscriber {

    /// The underlying WhisperKit pipeline.
    private let pipe: WhisperKit

    /// Loads the Whisper model, downloading it on first run.
    ///
    /// - Parameter model: The WhisperKit model identifier. Defaults to `"openai_whisper-base"`.
    public init(model: String = "openai_whisper-base") async throws {
        self.pipe = try await WhisperKit(model: model)
    }

    /// Transcribes the audio at the given URL and returns cleaned plain text.
    ///
    /// - Parameter audioFileURL: A local file URL pointing to the audio to transcribe.
    /// - Returns: The recognised speech as a plain-text string.
    /// - Throws: ``WhisperKitTranscriberError/noSpeechDetected`` if the audio
    ///   contains no recognisable speech after removing special tokens.
    public func transcribe(audioFileURL: URL) async throws -> String {
        let results = try await pipe.transcribe(audioPath: audioFileURL.path)
        let raw = results.map(\.text).joined(separator: " ")
        let cleaned = Self.clean(raw)
        guard !cleaned.isEmpty else { throw WhisperKitTranscriberError.noSpeechDetected }
        return cleaned
    }

    // MARK: - Private

    /// Strips Whisper's non-speech markers and control tokens, then normalises whitespace.
    ///
    /// Removed patterns:
    /// - `<|...|>` control tokens — timestamps (`<|0.00|>`) and sentinels (`<|endoftext|>`).
    /// - `[ALL_CAPS]` event markers — `[BLANK_AUDIO]`, `[MUSIC]`, `[NOISE]`, `[APPLAUSE]`, etc.
    private static func clean(_ text: String) -> String {
        var s = text
        s = s.replacing(#/<\|[^|>]+\|>/#, with: "")   // <|...|> control tokens
        s = s.replacing(#/\[[A-Z_]+\]/#,   with: "")   // [BLANK_AUDIO] etc.
        s = s.replacing(#/\s+/#,            with: " ")  // collapse whitespace
        return s.trimmingCharacters(in: .whitespaces)
    }
}
