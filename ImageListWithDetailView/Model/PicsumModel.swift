struct PicsumModel: Decodable, Identifiable, Hashable {
    var id: Int
    var format: String
    var width: Int
    var height: Int
    var filename: String
    var author: String
    var authorUrl: String
    var postUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case format
        case width
        case height
        case filename
        case author
        case authorUrl = "author_url"
        case postUrl = "post_url"
    }
    
    var imageUrl: String {
        return "https://picsum.photos/id/\(id)/100/100"
    }
}
