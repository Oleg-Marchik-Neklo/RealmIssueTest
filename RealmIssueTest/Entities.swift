//
//  Entities.swift
//  FetchListIssueTest
//
//  Created by Oleg Marchik on 12/9/19.
//  Copyright © 2019 NEKLO. All rights reserved.
//

import RealmSwift

public class Entity: Object {
    public let list = List<SubEntity>()
}

public class SubEntity: Object {
    
    public init(uid: String) {
        self.uid = uid
    }
    
    required init() {
        super.init()
    }
    
    @objc public dynamic var uid = ""
    
    override public static func primaryKey() -> String? {
        return "uid"
    }
}
