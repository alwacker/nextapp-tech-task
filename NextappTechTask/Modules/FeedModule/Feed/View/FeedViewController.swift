//
//  FeedViewController.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class FeedViewController: BaseViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private let viewModel: FeedViewModel
    private let disposeBag = DisposeBag()
    
//    private let dataSource: RxCollectionViewSectionedReloadDataSource<FeedViewModel.Sections>
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: FeedViewController.self), bundle: nil)
        rx.viewDidLoad
            .bind(to: viewModel.didLoad)
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupBinding() {
        
    }
}
