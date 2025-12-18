enum PicsumListViewState: Equatable {
    case loading
    case loaded([PicsumModel])
    case error(String)
}
