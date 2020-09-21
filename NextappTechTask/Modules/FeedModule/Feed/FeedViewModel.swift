//
//  FeedViewModel.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class FeedViewModel {
    typealias Section = SectionModel<Void, Story>
    //inputs
    let didLoad = PublishSubject<Void>()
    let selectedStory = PublishSubject<Story>()
    
    //outputs
    let sections: Driver<[Section]>
    let hud: Driver<HudStatus>
    
    private let disposeBag = DisposeBag()
    
    init(service: FeedService, router: FeedRouter) {
        let request = didLoad
            .mapTo("76794126980351029")
            .flatMap(service.getStories)
            .share()
        
        Observable.combineLatest(request.data(), selectedStory)
            .map { ($0.0.data, $0.1) }
            .subscribe(onNext: router.showPreview)
            .disposed(by: disposeBag)
        
        sections = request.data()
            .map { $0.data }
            .map { [Section(model: (), items: $0)] }
            .asDriver(onErrorDriveWith: .empty())
            
        hud = HudStatus.merge(request.hud())
    }
    
}
