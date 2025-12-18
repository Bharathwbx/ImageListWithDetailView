@testable import ImageListWithDetailView

class MockPicsumService: PicsumServiceProtocol {
    
    enum Behavior {
        case success([PicsumModel])
        case failure(Error)
        case empty
    }
    
    private let behavior: Behavior
    
    init(behavior: Behavior) {
        self.behavior = behavior
    }
    
    func fetchPicsumList() async throws -> [PicsumModel] {
        switch behavior {
        case .success(let items):
            return items
        case .failure(let error):
            throw error
        case .empty:
            return []
        }
    }
    
}
