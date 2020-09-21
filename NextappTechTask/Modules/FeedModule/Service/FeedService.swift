//
//  FeedService.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import RxSwift

class FeedService {
    private let api: FeedApi
    
    init(api: FeedApi) {
        self.api = api
    }
    
    func getStories(by userId: String) -> Observable<ApiEvent<FeedEntity>> {
        return api.getUserStories(with: userId)
    }
}
