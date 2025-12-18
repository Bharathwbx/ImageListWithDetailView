import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {
        cache.countLimit = 200
        cache.totalCostLimit = 200 * 1024 * 1024 // 200 MB
    }
    
    func get(_ key: NSURL) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    func set(_ key: NSURL, image: UIImage) {
        let cost = image.memoryCost
        cache.setObject(image, forKey: key, cost: cost)
    }
}
