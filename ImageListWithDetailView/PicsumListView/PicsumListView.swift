import SwiftUI

struct PicsumListView: View {
    
    @StateObject var viewModel = PicsumListViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Picsum")
                .task {
                    await viewModel.fetchIfNeeded()
                }
        }
    }
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading...")
        case .loaded(let picsumList):
            List(picsumList) { picsomeModel in
                NavigationLink(value: picsomeModel) {
                    PicsumRowView(picsumModel: picsomeModel)
                }
            }
            .navigationDestination(for: PicsumModel.self) { model in
                PicsumDetailView(picsumModel: model)
            }
        case .error(let message):
            InlineErrorView(message: message) {
                Task {
                    await viewModel.fetchPicsumList()
                }
            }
        }
    }
}

#Preview {
    PicsumListView()
}
