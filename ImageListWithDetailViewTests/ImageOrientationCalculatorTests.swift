import XCTest
@testable import ImageListWithDetailView

final class ImageOrientationCalculatorTests: XCTestCase {

    func testPortraitImage() {
        let width = 3333
        let height = 5000
        
        let orientation = ImageOrientationCalculator.orientation(
            width: width,
            height: height
        )
        
        XCTAssertEqual(.portrait, orientation)
    }
    
    func testLandscapeImage() {
        let width = 5000
        let height = 3333
        
        let orientation = ImageOrientationCalculator.orientation(
            width: width,
            height: height
        )
        
        XCTAssertEqual(.landscape, orientation)
    }
    
    func testSquareImageDefaultsToLandscape() {
        let width = 5000
        let height = 5000
        
        let orientation = ImageOrientationCalculator.orientation(
            width: width,
            height: height
        )
        
        XCTAssertEqual(.landscape, orientation)
    }
}
