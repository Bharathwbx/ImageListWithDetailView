import UIKit

actor ImageLoaderActor {
    static let shared = ImageLoaderActor()
    
    private let imageCache = ImageCache.shared
    
    private var inFlightTasks: [URL: Task<UIImage, Error>] = [:]
    
    func image(for url: URL) async throws -> UIImage {
        
        //Check cache
        if let cachedImage = imageCache.get(url as NSURL) {
            return cachedImage
        }
        
        // Duplicate concurrent requests
        if let task = inFlightTasks[url] {
            return try await task.value
        }
        
        //Create new fetch task
        let task = Task {
            defer { Task { removeTask(for: url) } }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw URLError(.cannotDecodeContentData)
            }
            
            imageCache.set(url as NSURL, image: image)
            return image
        }
        
        inFlightTasks[url] = task
        return try await task.value
    }
    
    private func removeTask(for url: URL) {
        inFlightTasks.removeValue(forKey: url)
    }
}
