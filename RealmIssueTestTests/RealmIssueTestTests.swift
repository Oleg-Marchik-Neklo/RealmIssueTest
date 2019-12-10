//
//  RealmIssueTestTests.swift
//  RealmIssueTestTests
//
//  Created by Oleg Marchik on 12/10/19.
//  Copyright © 2019 NEKLO. All rights reserved.
//

import XCTest
import Realm
import RealmSwift
@testable import RealmIssueTest

class RealmIssueTestTests: XCTestCase {

    var realm: Realm!
    
    override func setUp() {
        realm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: "TestRealm"))
        if realm == nil {
            XCTFail("Test Realm was not created")
        }
    }
    
    override func tearDown() {
        try? realm.write {
            realm.deleteAll()
        }
        realm = nil
    }
    
    func testFailed() {
        let mainEntity = Entity()
        
        let sub1 = SubEntity(uid: UUID().uuidString)
        let sub2 = SubEntity(uid: UUID().uuidString)
        
        try? realm.write {
            realm.add(mainEntity)
            
            mainEntity.list.insert(sub1, at: 0)
            mainEntity.list.insert(sub2, at: 0)
        }
        
        let list = realm.objects(Entity.self).first!.list
        let count = list.filter(NSPredicate(format: "NOT uid in %@", [sub1.uid])).count
        XCTAssertEqual(count, 1)
    }
    
    func testPassed1() {
        let mainEntity = Entity()
        
        let sub1 = SubEntity(uid: UUID().uuidString)
        let sub2 = SubEntity(uid: UUID().uuidString)
        
        try? realm.write {
            realm.add(mainEntity)
            
            mainEntity.list.insert(sub1, at: 0)
            mainEntity.list.insert(sub2, at: 1)
        }
        
        let list = realm.objects(Entity.self).first!.list
        let count = list.filter(NSPredicate(format: "NOT uid in %@", [sub1.uid])).count
        XCTAssertEqual(count, 1)
    }
    
    func testPassed2() {
        let mainEntity = Entity()
        
        let sub1 = SubEntity(uid: UUID().uuidString)
        let sub2 = SubEntity(uid: UUID().uuidString)
        
        try? realm.write {
            realm.add(mainEntity)
            
            mainEntity.list.insert(sub1, at: 0)
            mainEntity.list.insert(sub2, at: 0)
        }
        
        let list = realm.objects(Entity.self).first!.list
        let count = list.filter{ $0.uid != sub1.uid }.count
        XCTAssertEqual(count, 1)
    }
}
