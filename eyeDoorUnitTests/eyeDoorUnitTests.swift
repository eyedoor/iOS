//
//  eyeDoorUnitTests.swift
//  eyeDoorUnitTests
//
//  Created by Nathan Schlechte on 5/14/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import XCTest
@testable import eyeDoor

class eyeDoorUnitTests: XCTestCase {

    var startControllerUnderTest: UINavigationController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        super.setUp()
        startControllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController?
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        startControllerUnderTest = nil
        super.tearDown()
    }
    
    func testLoadEvents(){
        print("hello")
        
       
    }

    


}
