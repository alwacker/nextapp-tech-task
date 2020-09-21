//
//  UICollectionView+Rx.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 21/09/2020.
//

import Foundation
import RxSwift
import RxCocoa

public extension Reactive where Base: UICollectionView {
    var visibleIndexPaths : Observable<[IndexPath]> {
        return self.didScroll
            .map{ self.base.visibleCells }
            .map{ $0.map{ self.base.indexPath(for: $0) }.compactMap{ $0 }
        }
    }
    
    func scroll(animated: Bool, at position: UICollectionView.ScrollPosition) -> Binder<IndexPath> {
        return Binder(self.base) { collectionView, indexPath in
            collectionView.scrollToItem(at: indexPath, at: position, animated: animated)
        }
    }
    
    var selectItemAtIndexPath : Binder<IndexPath> {
        return Binder(self.base) { collectionView, indexPath in
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}
