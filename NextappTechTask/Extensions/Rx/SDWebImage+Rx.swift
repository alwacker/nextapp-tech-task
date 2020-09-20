//
//  SDWebImage+Rx.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import SDWebImage
import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIImageView {
    var setImage: Binder<String> {
        return Binder(self.base) { iv, string in
            iv.sd_setImage(with: URL(string: string))
        }
    }
}
