import UIKit
import Combine

public protocol PreviewIntroDelegate: AnyObject {
    func handlePreviewCompletion(isLoading: Bool)
}

open class PreviewIntroController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    public weak var delegate: PreviewIntroDelegate?
    private let viewModel: PreviewIntroViewModel
    private let viewNode: PreviewIntroNode

    open override func viewDidLoad() {
        super.viewDidLoad()
        viewNode.automaticallyManagesSubnodes = true
        setupView()
        setupBindings()
    }

    private func setupBindings() {
        viewModel.currentPreview
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.viewNode.configure(with: item)
            }
            .store(in: &cancellables)

        viewModel.isLoading
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.delegate?.handlePreviewCompletion(isLoading: isLoading)
            }
            .store(in: &cancellables)
    }

    private func setupView() {
        view = viewNode.view
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startPreview()
    }

    public init(viewModel: PreviewIntroViewModel, viewNode: PreviewIntroNode) {
        self.viewModel = viewModel
        self.viewNode = viewNode
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
