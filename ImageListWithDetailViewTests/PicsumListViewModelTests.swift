import XCTest

@testable import ImageListWithDetailView

@MainActor
class PicsumListViewModelTests: XCTestCase {
    
    private var mockService: MockPicsumService!
    private var viewModel: PicsumListViewModel!
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchPicsumListSuccess() async throws {
        let data = try XCTUnwrap(JsonReaderHelper.loadJasonData(for: "picsum-lists"))
        let picsumList = try JSONDecoder().decode([PicsumModel].self, from: data)
        
        mockService = MockPicsumService(behavior: .success(picsumList))
                
        viewModel = PicsumListViewModel(picSumService: mockService)

        await viewModel.fetchIfNeeded()
        
        XCTAssertEqual(viewModel.state, .loaded(picsumList))
    }
    
    func testFetchPicsumFailure() async {
        
        mockService = MockPicsumService(behavior: .failure(APIError.invalidResponse))
        
        viewModel = PicsumListViewModel(picSumService: mockService)
        
        await viewModel.fetchIfNeeded()
        
        XCTAssertEqual(viewModel.state, .error("Invalid server response"))
    }
    
    func testFetchPicsumEmpty() async {
        mockService = MockPicsumService(behavior: .empty)
        
        viewModel = PicsumListViewModel(picSumService: mockService)
        
        await viewModel.fetchIfNeeded()
        
        XCTAssertEqual(viewModel.state, .loaded([]))
    }
}
