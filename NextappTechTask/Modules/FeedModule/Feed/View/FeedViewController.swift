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
    private struct Cells {
        static let feedCell = ReusableCell<FeedCell>(nibName: "FeedCell")
    }
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(Cells.feedCell)
            if let flowLayout = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout) {
                flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2 ) - 5, height: 350)
            }
            viewModel.sections
                .drive(collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
            collectionView.rx.modelSelected(Story.self)
                .bind(to: viewModel.selectedStory)
                .disposed(by: disposeBag)
        }
    }
    private let viewModel: FeedViewModel
    private let disposeBag = DisposeBag()
    
    private let dataSource: RxCollectionViewSectionedReloadDataSource<FeedViewModel.Section>
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        self.dataSource = .init(configureCell: { (ds, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeue(Cells.feedCell, for: indexPath)
            cell.setupUI(with: item)
            return cell
        })
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
        title = "Stories"
        setupBinding()
    }
    
    private func setupBinding() {
        ProgressHud.rx
            .observe(status: viewModel.hud)
            .disposed(by: disposeBag)
    }
}
