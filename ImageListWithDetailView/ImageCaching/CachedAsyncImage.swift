import SwiftUI

struct CachedAsyncImage<Placeholder: View>: View {
    let url: URL?
    let placeholder: Placeholder
    
    @State private var loadedImage: UIImage?
    @State private var isLoading = false
    
    init(url: URL?, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder()
    }
    
    var body: some View {
        if let loadedImage = loadedImage {
            Image(uiImage: loadedImage)
                .resizable()
        } else if isLoading {
            placeholder
        } else {
            Color.clear
                .task {
                    await load()
                }
        }
    }
    
    private func load() async {
        guard !isLoading else { return }
        isLoading = true
        guard let url = url else { return }
        
        //Return cached image
        do {
            loadedImage = try await ImageLoaderActor.shared.image(for: url)
        } catch {
            //fallback  image
            loadedImage = UIImage(systemName: "photo")
        }
        isLoading = false
    }
}
