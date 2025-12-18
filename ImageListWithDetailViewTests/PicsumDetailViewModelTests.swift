import XCTest

@testable import ImageListWithDetailView

class PicsumDetailViewModelTests: XCTestCase {
    
    func testLandscapeImageDetection() throws {
        let data = try XCTUnwrap(JsonReaderHelper.loadJasonData(for: "picsum-landscape-item"))
        let picsumModelForLandscape = try JSONDecoder().decode(PicsumModel.self, from: data)

        let viewModel = PicsumDetailViewModel(picsumModel: picsumModelForLandscape)
        
        XCTAssertEqual(viewModel.orientation, .landscape)
        XCTAssertNotEqual(viewModel.orientation, .portrait)
    }
    
    func testPortraitImageDetection() throws {
        let data = try XCTUnwrap(JsonReaderHelper.loadJasonData(for: "picsum-portrait-item"))
        let picsumModelForPortrait = try JSONDecoder().decode(PicsumModel.self, from: data)

        let viewModel = PicsumDetailViewModel(picsumModel: picsumModelForPortrait)
        
        XCTAssertEqual(viewModel.orientation, .portrait)
        XCTAssertNotEqual(viewModel.orientation, .landscape)
    }
    
    func testImageURLFormedCorrectly() throws {
        let data = try XCTUnwrap(JsonReaderHelper.loadJasonData(for: "picsum-landscape-item"))
        let picsumModel = try JSONDecoder().decode(PicsumModel.self, from: data)
        
        let viewModel = PicsumDetailViewModel(picsumModel: picsumModel)

        let url = viewModel.imageUrl
        
        XCTAssertEqual(url?.absoluteString, "https://picsum.photos/5000/3333?image=0")
    }
    
    func testAuthorName() throws {
        let data = try XCTUnwrap(JsonReaderHelper.loadJasonData(for: "picsum-landscape-item"))
        let picsumModel = try JSONDecoder().decode(PicsumModel.self, from: data)

        let viewModel = PicsumDetailViewModel(picsumModel: picsumModel)
        
        XCTAssertEqual(viewModel.authorName, "Alejandro Escamilla")
    }
}
