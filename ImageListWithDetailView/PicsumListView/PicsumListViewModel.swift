import Foundation

@MainActor
class PicsumListViewModel: ObservableObject {
        
    private let picSumService: PicsumServiceProtocol

    @Published var state: PicsumListViewState = .loading
    
    private var hasLoaded = false
        
    init(picSumService: PicsumServiceProtocol = PicsumService()) {
        self.picSumService = picSumService
    }
    
    func fetchIfNeeded() async {
        guard !hasLoaded else { return }
        await fetchPicsumList()
    }
    
    func fetchPicsumList() async {
        print("fetchPicsumList....")
        state = .loading
        
        do {
            let picsumList = try await picSumService.fetchPicsumList()
            state = .loaded(picsumList)
            hasLoaded = true
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
