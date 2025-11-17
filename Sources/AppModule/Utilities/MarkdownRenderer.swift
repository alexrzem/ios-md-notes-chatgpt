import SwiftUI

struct MarkdownRenderer: View {
    let text: String
    var foregroundColor: Color = ThemePalette.textPrimary

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let attributed = try? AttributedString(markdown: text) {
                    Text(attributed)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text(text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(24)
            .foregroundStyle(foregroundColor)
        }
        .background(ThemePalette.previewBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}
