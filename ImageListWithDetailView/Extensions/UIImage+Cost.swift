import UIKit

extension UIImage {
    var memoryCost: Int {
        guard let cgImage = cgImage else { return 1 }
        return cgImage.bytesPerRow * cgImage.height
    }
}
