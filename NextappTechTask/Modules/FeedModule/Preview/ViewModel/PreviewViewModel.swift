//
//  PreviewViewModel.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class PreviewViewModel {
    typealias Section = SectionModel<Void, Story>
    
    struct SelectedItem: Equatable {
        let item: Story
        let index: Int
        
        static func ==(lhs: PreviewViewModel.SelectedItem, rhs: PreviewViewModel.SelectedItem) -> Bool {
            return lhs.item == rhs.item && lhs.index == rhs.index
        }
    }
    
    //inputs
    let didLoad = PublishSubject<Void>()
    let pageSelected = PublishSubject<Int>()
    let dismissButtonPressed = PublishSubject<Void>()
    
    //outputs
    let sections: Driver<[Section]>
    let selectedItem: Driver<SelectedItem>
    let firstIndex: Driver<IndexPath>
    
    private let disposeBag = DisposeBag()
    
    init(selectedStory: Story, stories: [Story], context: FeedRouter.Context) {
        selectedItem = pageSelected
            .map { (stories: stories, selected: $0) }
            .flatMap { tuple -> Observable<SelectedItem> in
                let (stories, selected) = tuple
                var items = [Story]()
                
                let selectedItem = stories[selected]
                items.append(selectedItem)
                return Observable
                    .from(items)
                    .map { SelectedItem(item: $0, index: selected) }
            }.asDriver(onErrorDriveWith: .empty())
        
        dismissButtonPressed
            .bind(to: context.dismiss)
            .disposed(by: disposeBag)
        
        let firstLoadedIndex = didLoad
            .mapTo(stories.firstIndex(where: { $0.id == selectedStory.id } ) ?? 0)
    
        firstIndex = firstLoadedIndex
            .delay(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .map { IndexPath(item: $0, section: 0) }
            .asDriver(onErrorDriveWith: .empty())
        
        sections = didLoad
            .mapTo(stories)
            .map { [Section(model: (), items: $0)] }
            .asDriver(onErrorDriveWith: .empty())
    }
}
