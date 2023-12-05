//
//  DictionaryController.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import SwiftUI

class DictionaryController: UIViewController {
    let viewModel: DictionaryViewModel

    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwiftUISubview()

        let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene
        if let statusBarFrame = windowScene?.statusBarManager?.statusBarFrame {
            let blurEffect = UIBlurEffect(style: .regular)
            let statusBarBackgroundView = UIVisualEffectView(effect: blurEffect)
            statusBarBackgroundView.frame = statusBarFrame
            view.addSubview(statusBarBackgroundView)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Private Methods
private extension DictionaryController {
    func configureSwiftUISubview() {
        let child = UIHostingController(rootView: DictionaryView(viewModel: viewModel))
        addChild(child)
        view.addSubview(child.view)
        child.view.constrain(to: view)
        child.didMove(toParent: self)
        view.backgroundColor = .systemBackground
        child.view.backgroundColor = view.backgroundColor
    }
}
