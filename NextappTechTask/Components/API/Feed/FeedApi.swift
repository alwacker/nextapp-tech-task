//
//  FeedApi.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 20/09/2020.
//

import Foundation
import RxSwift

class FeedApi: BaseApi {
    
    func getUserStories(with id: String) -> Observable<ApiEvent<FeedEntity>> {
        let endpoint = String(format: ApiEndPoint.userStories.rawValue, id)
        return request(endPoint: endpoint)
    }
}
