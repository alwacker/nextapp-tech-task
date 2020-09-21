//
//  FeedEntity.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 20/09/2020.
//

import Foundation

struct FeedEntity: Decodable {
    let data: [Story]
}

struct Story: Decodable, Equatable {
    let id: String
    let user: User
    let cover_src: String
    let landscape_share_image: String
    let feed_preview_video: String?
    let title: String
    let likes: Likes
}

struct User: Decodable, Equatable {
    let display_name: String
    let avatar_image_url: String
}

struct Likes: Decodable, Equatable {
    let count: Int
}
