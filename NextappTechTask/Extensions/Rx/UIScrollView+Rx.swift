//
//  UIScrollView+Rx.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 20/09/2020.
//

import Foundation
import RxSwift
import RxCocoa

public extension Reactive where Base: UIScrollView {
    var pageSelected: Observable<Int> {
        return didEndDecelerating
            .map { [weak base] _ -> Int in
                guard let base = base else { return 0 }
                return lround(Double(base.contentOffset.x / base.frame.width))
            }
    }
}
