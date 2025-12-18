import SwiftUI

struct PicsumDetailView: View {
    
    @StateObject var viewModel: PicsumDetailViewModel
    
    init(picsumModel: PicsumModel) {
        _viewModel = StateObject(wrappedValue: PicsumDetailViewModel(picsumModel: picsumModel))
    }
    
    var body: some View {
        
        if let url = viewModel.imageUrl {
            VStack {
                switch viewModel.orientation {
                case .portrait:
                    CachedAsyncImage(url: url) {
                      ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    }
                    .aspectRatio(contentMode: .fit)
                    
                    Text(viewModel.authorName)
                        .font(.headline)
                        .padding(.top, 12)
                    
                    Spacer()
                case .landscape:
                    Spacer()
                    
                    CachedAsyncImage(url: url) {
                      ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                    }
                    .aspectRatio(contentMode: .fit)
                    
                    Text(viewModel.authorName)
                        .font(.headline)
                        .padding(.top, 12)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    PicsumDetailView(picsumModel: PicsumModel(id: 0, format: "jpeg", width: 2002, height: 2001, filename: "1.jpeg", author: "Alejandro Escamilla", authorUrl: "https://unsplash.com/photos/LNRyGwIJr5c", postUrl: "https://unsplash.com/photos/LNRyGwIJr5c"))
}
