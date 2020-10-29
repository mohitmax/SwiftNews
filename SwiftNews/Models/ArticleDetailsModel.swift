//
//  ArticleModel.swift
//  SwiftNews
//
//  Created by Mohit Sadhu on 2020-10-26.
//

import Foundation

struct ArticleResponseModel: Codable {
    var kind: String
    var data: ArticleApiData
}

struct ArticleApiData: Codable {
    var modhash: String
    var dist: Int
    var children: [Article]
}

struct Article: Codable {
    var kind: String
    var data: ArticleDetailsModel
}

struct ArticleDetailsModel: Codable {
    
    var title: String
    var articleUrl: String //article URL
    var selftext: String //another title-like text. Can be empty.
    var selftextHtml: String? //html representation of the selftext. Can be null is selftext is empty
    var thumbnailUrl: String? //url as string for a thumbnail image - can be null
    var thumbnailHeight: Int? //can be null
    var thumbnailWidth: Int? //can be null
    
    enum RootKeys: String, CodingKey {
        case title, selftext
        case articleUrl = "url"
        case selftexthtml = "selftext_html"
        case thumbnailUrl = "thumbnail"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
    }
    
    mutating func updateThumbnailUrl() {
        if self.thumbnailUrl?.caseInsensitiveCompare("self") == .orderedSame {
            self.thumbnailUrl = nil
            return
        }
        
        if let thumbnailUrlString = thumbnailUrl, !thumbnailUrlString.isEmpty {
            self.thumbnailUrl = thumbnailUrlString.replacingOccurrences(of: "&amp;", with: "&")
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.articleUrl = try container.decode(String.self, forKey: .articleUrl)
        self.selftext = try container.decode(String.self, forKey: .selftext)
        self.selftextHtml = try container.decodeIfPresent(String.self, forKey: .selftexthtml)
        self.thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        self.thumbnailHeight = try container.decodeIfPresent(Int.self, forKey: .thumbnailHeight)
        self.thumbnailWidth = try container.decodeIfPresent(Int.self, forKey: .thumbnailWidth)
    }
}
