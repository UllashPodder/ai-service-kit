import AIServiceKit

/// Prompt templates used by ``MLXLlamaSummarizer`` for each ``SummaryFormat``.
///
/// Inject a custom instance via ``MLXLlamaSummarizer/init(prompts:)`` to override
/// wording, language, or tone without subclassing.
public struct SummaryPrompts: Sendable {

    /// The system prompt sent before the transcript for each format.
    public let systemPrompt: @Sendable (SummaryFormat) -> String

    /// The user-turn message that wraps the transcript for each format.
    public let userPrompt: @Sendable (SummaryFormat, _ transcript: String) -> String

    /// Creates a ``SummaryPrompts`` with custom closures.
    public init(
        systemPrompt: @escaping @Sendable (SummaryFormat) -> String,
        userPrompt: @escaping @Sendable (SummaryFormat, String) -> String
    ) {
        self.systemPrompt = systemPrompt
        self.userPrompt = userPrompt
    }

    /// Default English prompts for all four ``SummaryFormat`` cases.
    public static let `default` = SummaryPrompts(
        systemPrompt: { format in
            switch format {
            case .briefDescription:
                return """
                    You are a concise assistant. Given a spoken transcript, write a single \
                    short paragraph (2–4 sentences) that captures the core topic and any key \
                    outcome. Plain prose only — no bullet points, no headers, no preamble.
                    """
            case .meetingMinutes:
                return """
                    You are a professional note-taker. Given a spoken transcript, produce \
                    structured meeting minutes with three sections: Attendees (infer from \
                    context or write "Not specified"), Discussion Points, and Action Items. \
                    Use plain markdown headings (## Section). Be factual and concise.
                    """
            case .bulletPoints:
                return """
                    You are a concise assistant. Given a spoken transcript, extract the main \
                    points as a markdown unordered list. Use short, factual bullets. Maximum \
                    10 bullets. No preamble.
                    """
            case .actionItems:
                return """
                    You are a task-extraction assistant. Given a spoken transcript, list only \
                    the concrete action items as a markdown unordered list. Each item must name \
                    an owner (or write "TBD") and a clear task. Omit discussion; list tasks only.
                    """
            }
        },
        userPrompt: { _, transcript in
            "Transcript:\n\(transcript)"
        }
    )
}
