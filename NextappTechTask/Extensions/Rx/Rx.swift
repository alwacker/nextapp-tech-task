//
//  Rx.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import RxSwift
import RxSwiftExt
import RxCocoa

public extension Observable {
    func toVoid() -> Observable<Void> {
        return mapTo(())
    }
}

public extension SharedSequence {
    func unwrap<T>() -> SharedSequence<SharedSequence.SharingStrategy, T> where Element == T? {
        return self.filter {
            $0 != nil
            }.map {
                $0!
        }
    }
}

public extension ControlProperty {
    func unwrap<T>() -> Observable<T> where Element == T? {
        return self.filter {
            $0 != nil
            }.map {
                $0!
        }
    }
}

public extension SharedSequence {
    func toVoid() -> SharedSequence<SharedSequence.SharingStrategy, Void> {
        return map { _ in
            Void()
        }
    }
}

extension Disposable {
    @discardableResult
    public func disposed(by bag: CompositeDisposable) -> CompositeDisposable.DisposeKey? {
        return bag.insert(self)
    }
}


