import Foundation
import Combine

@MainActor
final class NotesStore: ObservableObject {
    @Published private(set) var notes: [Note] = []
    @Published var currentNote: Note = Note()

    private let storageURL: URL
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(fileManager: FileManager = .default) {
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            ?? fileManager.temporaryDirectory
        let folder = directory.appendingPathComponent("MarkdownNotes", isDirectory: true)
        if !fileManager.fileExists(atPath: folder.path) {
            try? fileManager.createDirectory(at: folder, withIntermediateDirectories: true)
        }
        storageURL = folder.appendingPathComponent("notes.json")

        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601

        loadNotes()
        startNewNote()
    }

    func startNewNote() {
        let timestamp = Self.timestampFormatter.string(from: Date())
        currentNote = Note(title: timestamp, contents: "")
        saveCurrentNote()
    }

    func update(contents: String) {
        currentNote.contents = contents
        currentNote.updatedAt = Date()
        if currentNote.title.isEmpty {
            currentNote.title = Self.timestampFormatter.string(from: currentNote.createdAt)
        }
        saveCurrentNote()
    }

    func updateTitle(_ title: String) {
        currentNote.title = title
        currentNote.updatedAt = Date()
        saveCurrentNote()
    }

    private func saveCurrentNote() {
        if let existingIndex = notes.firstIndex(where: { $0.id == currentNote.id }) {
            notes[existingIndex] = currentNote
        } else {
            notes.insert(currentNote, at: 0)
        }
        persistNotes()
    }

    private func persistNotes() {
        do {
            let data = try encoder.encode(notes)
            try data.write(to: storageURL, options: .atomic)
        } catch {
            #if DEBUG
            print("Failed to persist notes: \(error.localizedDescription)")
            #endif
        }
    }

    private func loadNotes() {
        do {
            let data = try Data(contentsOf: storageURL)
            notes = try decoder.decode([Note].self, from: data)
        } catch {
            notes = []
        }
    }

    private static let timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        return formatter
    }()
}
