import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: NotesStore
    @State private var isShowingHistory = false

    var body: some View {
        GeometryReader { proxy in
            let isCompact = proxy.size.width < 700
            mainContent(isCompact: isCompact)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(ThemePalette.background.ignoresSafeArea())
        }
        .preferredColorScheme(.dark)
    }

    @ViewBuilder
    private func mainContent(isCompact: Bool) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            if isCompact {
                editor
                preview
            } else {
                HStack(alignment: .top, spacing: 24) {
                    editor
                    preview
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 32)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Markdown Notes")
                .font(.system(.largeTitle, weight: .bold, design: .rounded))
                .foregroundStyle(ThemePalette.accent)
            Text(store.currentNote.title)
                .font(.headline)
                .foregroundStyle(ThemePalette.secondaryAccent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var editor: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Markdown Editor")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
            TextEditor(text: Binding(
                get: { store.currentNote.contents },
                set: { store.update(contents: $0) }
            ))
            .scrollContentBackground(.hidden)
            .textInputAutocapitalization(.sentences)
            .font(.system(size: 18, weight: .regular, design: .monospaced))
            .foregroundStyle(ThemePalette.textPrimary)
            .padding(16)
            .background(ThemePalette.editorBackground)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(ThemePalette.accent.opacity(0.4), lineWidth: 1)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var preview: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Live Preview")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
            MarkdownRenderer(text: store.currentNote.contents)
                .animation(.easeInOut, value: store.currentNote.contents)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ContentView()
        .environmentObject(NotesStore())
}
