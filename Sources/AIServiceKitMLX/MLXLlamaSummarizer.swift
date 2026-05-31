import AIServiceKit
import Foundation
import Hub
import MLXLLM
import MLXLMCommon

/// On-device summarizer backed by Llama 3.2 3B Instruct (4-bit quantised) via MLX.
///
/// The model is downloaded from Hugging Face on first use and cached locally.
/// All inference runs on-device; no data leaves the device.
///
/// ## Usage
/// ```swift
/// let summarizer = try await MLXLlamaSummarizer()
/// let summary = try await summarizer.summarize(transcript, format: .briefDescription)
/// ```
public final actor MLXLlamaSummarizer: AISummarizer {

    /// Hugging Face repo ID for the model.
    public static let modelID = "mlx-community/Llama-3.2-3B-Instruct-4bit"

    /// Pinned commit hash. Bump deliberately when you want to adopt a new model revision.
    public static let modelRevision = "7f0dc925e0d0afb0322d96f9255cfddf2ba5636e"

    private let container: ModelContainer
    private let prompts: SummaryPrompts

    /// Loads the model, downloading it on first run.
    ///
    /// - Parameter prompts: Prompt templates to use. Defaults to ``SummaryPrompts/default``.
    public init(prompts: SummaryPrompts = .default) async throws {
        let configuration = ModelConfiguration(
            id: Self.modelID,
            revision: Self.modelRevision
        )
        self.container = try await loadModelContainer(configuration: configuration) { progress in
            if progress.fractionCompleted == 1.0 {
                print(
                    "[AIServiceKitMLX] Model ready — \(Self.modelID)@\(Self.modelRevision)"
                )
            }
        }
        self.prompts = prompts
        print("[AIServiceKitMLX] Loaded \(Self.modelID) revision \(Self.modelRevision)")
    }

    /// Summarizes a transcript using the specified format.
    ///
    /// - Parameters:
    ///   - transcript: The full text of the spoken transcript to summarize.
    ///   - format: The desired output format.
    /// - Returns: A plain-text (or markdown) summary string.
    public func summarize(_ transcript: String, format: SummaryFormat) async throws -> String {
        let system = prompts.systemPrompt(format)
        let user = prompts.userPrompt(format, transcript)

        let session = ChatSession(
            container,
            instructions: system,
            generateParameters: .init(maxTokens: 512)
        )
        let result = try await session.respond(to: user)
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
