//
//  Friend.swift
//  Friends
//
//  Created by Nivardo Ibarra on 12/28/15.
//  Copyright © 2015 Nivardo Ibarra. All rights reserved.
//

import Foundation

enum Gender: Int {
    case Male = 1, Female = 2
}

class Friend {
    var name: String?
    var lastName: String?
    var twitter: String?
    var gender: Gender?
    
    init(name: String, lastName: String) {
        self.name = name
        self.lastName = lastName
    }
    
    convenience init() {
        self.init(name: "Anyone", lastName: "Anyone")
    }
    
    var fullName: String {
        get{
            return "\(lastName!), \(name!)"
        }
    }
    
    // method's class
    class func fromDictionary(dictionary: NSDictionary) -> [Friend]{
        var friends = [Friend]()
        let list = dictionary["friends"] as! NSArray
        list.enumerateObjectsWithOptions(NSEnumerationOptions(), usingBlock: { (item, idx, stop) -> Void in
            let name = item["first_name"] as! String
            let lastName = item["last_name"] as! String
            let friend = Friend(name: name, lastName: lastName)
            friend.twitter = item["twitter"] as? String
            let friendGender = item["gender"] as! String
            if friendGender == "male" {
                friend.gender = Gender.Male
            }else {
                friend.gender = Gender.Female
            }
            friends.append(friend)
        })
        return friends
    }
}