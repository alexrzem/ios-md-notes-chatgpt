import Foundation

struct Note: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var contents: String
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        title: String = "",
        contents: String = "",
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.contents = contents
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
