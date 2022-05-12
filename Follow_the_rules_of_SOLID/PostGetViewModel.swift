//
//  PostGetViewModel.swift
//  Follow_the_rules_of_SOLID
//
//  Created by 이민지 on 2022/05/12.
//

import UIKit
import Foundation
import RealmSwift

protocol setDataProtocol {
    func setData(post: Post)
}

protocol getDataCountProtocol {
    func getDataCount() -> Int
}

protocol getDataProtocol {
    func getData() -> [Post]
}

protocol setPostDataProtocol {
    func postData(title: String, contents: String) -> Post
}

class PostGetViewModel {
    let dataCount: getPostDataCount = .init()
    let data: getPostData = .init()
    
    func getDataCount() -> Int {
        dataCount.getDataCount()
    }
    
    func postData(completion: @escaping (([Post]) -> ())) {
        completion(data.getData())
    }
}

class PostSetViewModel {
    let setPost: setPost = .init()
    let postData: postData = .init()
    
    func setPostData(title: String, contents: String) {
        let posts = postData.postData(title: title, contents: contents)
        setPost.setData(post: posts)
    }
}

class setPost: setDataProtocol {
    let realm = try! Realm()
    
    func setData(post: Post) {
        try! realm.write {
            realm.add(post)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
}

class postData: setPostDataProtocol {
    func postData(title: String, contents: String) -> Post {
        let post = Post(title: title, contents: contents)
        return post
    }
}

class getPostDataCount: getDataCountProtocol {
    let realm = try! Realm()
    
    func getDataCount() -> Int {
        let data = realm.objects(Post.self)
        return data.count
    }
}

class getPostData: getDataProtocol {
    let realm = try! Realm()
    
    func getData() -> [Post] {
        let data = realm.objects(Post.self)
        var post: [Post] = []
        
        for db in data {
            post.append(db)
        }
        return post
    }
}
