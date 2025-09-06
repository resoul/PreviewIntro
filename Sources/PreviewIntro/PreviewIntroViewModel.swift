import UIKit
import Combine

public protocol PreviewIntroViewModel {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var currentPreview: AnyPublisher<Preview?, Never> { get }

    func getPreview() -> Preview
    func startPreview()
}

public class PreviewIntroViewModelImpl: PreviewIntroViewModel {
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    private let currentPreviewSubject = CurrentValueSubject<Preview?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()
    private let previewItems: [Preview]

    public var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }

    public var currentPreview: AnyPublisher<Preview?, Never> {
        currentPreviewSubject.eraseToAnyPublisher()
    }

    public func getPreview() -> Preview {
        guard let item = previewItems.randomElement() else {
            fatalError("Preview must be provided")
        }

        return item
    }

    public func startPreview() {
        currentPreviewSubject.send(getPreview())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isLoadingSubject.send(false)
        }
    }

    public init (items: [Preview] = []) {
        previewItems = items
    }
}
