import SwiftUI

struct PicsumRowView: View {
    let picsumModel: PicsumModel
    
    var body: some View {
        HStack(spacing: 10) {
            CachedAsyncImage(url: URL(string: picsumModel.imageUrl)) {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Text(picsumModel.filename)
        }
    }
}
