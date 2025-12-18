import Foundation
class JsonReaderHelper {
    static func loadJasonData(for fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        return FileManager.default.contents(atPath: path)
    }
}
