//
//  FeedRouter.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import RxSwift
import Swinject

class FeedRouter {
    
    private let assembler: Assembler
    private let transitionHandler: TransitionHandler
    private let disposeBag = DisposeBag()
    
    init(assembler: Assembler, transitionHandler: TransitionHandler) {
        self.assembler = assembler
        self.transitionHandler = transitionHandler
    }
    
    class Context {
        let dismiss = PublishSubject<Void>()
    }
    
    func showPreview(with stories: [Story], selectedStory: Story) {
        let context = Context()
        
        let vc = assembler
            .with(assemblies: PreviewViewAssembly())
            .with(globals: stories, selectedStory, context)
            .resolver
            .resolve(PreviewViewController.self)!
        
        context.dismiss
            .subscribe(onNext: { [weak vc] in
                vc?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        transitionHandler.modal(controller: vc, animated: true)
    }
}
