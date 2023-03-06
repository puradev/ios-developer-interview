import Foundation

public enum DataState<Model: Equatable>: Equatable {
    case loaded(Model)
    case loading
    case error(description: String)
    case idle
}
