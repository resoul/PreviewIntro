import UIKit
import Combine

public protocol PreviewIntroViewModel {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var currentPreview: AnyPublisher<PreviewIntro?, Never> { get }

    func getPreview() -> PreviewIntro
    func startPreview()
}

public class PreviewIntroViewModelImpl: PreviewIntroViewModel {
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    private let currentPreviewSubject = CurrentValueSubject<PreviewIntro?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()
    private let previewItems: [PreviewIntro]

    public var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }

    public var currentPreview: AnyPublisher<PreviewIntro?, Never> {
        currentPreviewSubject.eraseToAnyPublisher()
    }

    public func getPreview() -> PreviewIntro {
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

    public init (items: [PreviewIntro] = []) {
        previewItems = items
    }

    deinit {
        cancellables.removeAll()
    }
}
