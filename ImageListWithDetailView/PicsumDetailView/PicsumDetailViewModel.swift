import Foundation

class PicsumDetailViewModel: ObservableObject {
    let picsumModel: PicsumModel

    init(picsumModel: PicsumModel) {
        self.picsumModel = picsumModel
    }
    
    var authorName: String {
        return picsumModel.author
    }
    
    var orientation: ImageOrientation {
        ImageOrientationCalculator.orientation(
            width: picsumModel.width,
            height: picsumModel.height
        )
    }
    
    deinit {
        print("deinit PicsumDetailViewModel")
    }
    
    var imageUrl: URL? {
        URL(string: "https://picsum.photos/\(picsumModel.width)/\(picsumModel.height)?image=\(picsumModel.id)")
    }
}
