//
//  PreviewViewController.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PreviewViewController: BaseViewController {
    private struct Cells {
        static let storyCell = ReusableCell<StoryCell>(nibName: "StoryCell")
    }
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(Cells.storyCell)
            setupCollectionView()
            
            collectionView.rx
                .pageSelected
                .subscribe(viewModel.pageSelected)
                .disposed(by: disposeBag)
            
            viewModel.sections
                .drive(collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)

            viewModel.firstIndex
                .drive(collectionView.rx.scroll(animated: false, at: .centeredHorizontally))
                .disposed(by: disposeBag)
        }
    }
    
    private let viewModel: PreviewViewModel
    private let disposeBag = DisposeBag()
    private let dataSource: RxCollectionViewSectionedReloadDataSource<PreviewViewModel.Section>
    
    init(viewModel: PreviewViewModel) {
        self.viewModel = viewModel
        self.dataSource = .init(configureCell: { (ds, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeue(Cells.storyCell, for: indexPath)
            cell.setupUI(with: item, viewModel: viewModel)
            return cell
        })
        
        super.init(nibName: String(describing: PreviewViewController.self), bundle: nil)
        
        rx.viewDidLoad
            .bind(to: viewModel.didLoad)
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = collectionView.collectionViewLayout as? AnimatedCollectionViewLayout else { return }
        flowLayout.itemSize = collectionView.frame.size
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupCollectionView() {
        let layout = AnimatedCollectionViewLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.animator = CubeAttributesAnimator()
        collectionView.collectionViewLayout = layout
    }
}
