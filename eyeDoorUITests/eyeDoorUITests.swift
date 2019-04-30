//
//  eyeDoorUITests.swift
//  eyeDoorUITests
//
//  Created by Nathan Schlechte on 4/30/19.
//  Copyright © 2019 Nathan Schlechte. All rights reserved.
//

import XCTest

class eyeDoorUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginLogoutSuccess() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"eyeDoor.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.children(matching: .textField).element.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.keys["m"].tap()
        XCUIDevice.shared.orientation = .portrait
        element.children(matching: .secureTextField).element.tap()
        XCUIDevice.shared.orientation = .faceUp
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .portrait
        loginButton.tap()
        XCUIDevice.shared.orientation = .faceUp
        app.navigationBars["Home"].buttons["Menu"].tap()
        app.buttons["Account"].tap()
        app.buttons["Logout"].tap()
        
        
    }
    
    func testLoginLogoutFail(){
        
        let app = XCUIApplication()
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"eyeDoor.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.children(matching: .textField).element.tap()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        XCUIDevice.shared.orientation = .portrait
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        XCUIDevice.shared.orientation = .faceUp
        
        let key = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        key.tap()
        app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        mKey.tap()
        mKey.tap()
        XCUIDevice.shared.orientation = .portrait
        element.children(matching: .secureTextField).element.tap()
        XCUIDevice.shared.orientation = .faceUp
        rKey.tap()
        eKey.tap()
        sKey.tap()
        tKey.tap()
        tKey.tap()
        loginButton.tap()
        app.alerts["Error"].buttons["OK"].tap()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
    }
    
    func testSignUpPhoneNumberFail(){
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
        let app = XCUIApplication()
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"eyeDoor.SignUpView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.children(matching: .textField).element(boundBy: 0).tap()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
        let suggestionElement = app/*@START_MENU_TOKEN@*/.otherElements["suggestion"]/*[[".keyboards",".otherElements[\"Typing Predictions\"].otherElements[\"suggestion\"]",".otherElements[\"suggestion\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        suggestionElement.tap()
        element.children(matching: .textField).element(boundBy: 1).tap()
        suggestionElement.tap()
        element.children(matching: .textField).element(boundBy: 2).tap()
        app/*@START_MENU_TOKEN@*/.otherElements["Typing Predictions"]/*[[".keyboards.otherElements[\"Typing Predictions\"]",".otherElements[\"Typing Predictions\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).matching(identifier: "suggestion").element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 3).tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        
        let key3 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        
        element.children(matching: .secureTextField).element(boundBy: 0).tap()
        
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        key.tap()
        key2.tap()
        key3.tap()
        key3.tap()
        element.children(matching: .secureTextField).element(boundBy: 1).tap()
        moreKey.tap()
        key.tap()
        key2.tap()
        //key3.tap()
        XCUIDevice.shared.orientation = .portrait
        signUpButton.tap()
        XCUIDevice.shared.orientation = .faceUp
        XCUIDevice.shared.orientation = .portrait
        app.alerts["Phone Number Incorrect"].buttons["OK"].tap()
        XCUIDevice.shared.orientation = .faceUp
        
    }
    
    func testPasswordMatchFail(){
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
        let app = XCUIApplication()
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"eyeDoor.SignUpView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.children(matching: .textField).element(boundBy: 0).tap()
        
        let suggestionElement = app/*@START_MENU_TOKEN@*/.otherElements["suggestion"]/*[[".keyboards",".otherElements[\"Typing Predictions\"].otherElements[\"suggestion\"]",".otherElements[\"suggestion\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        suggestionElement.tap()
        element.children(matching: .textField).element(boundBy: 1).tap()
        suggestionElement.tap()
        XCUIDevice.shared.orientation = .portrait
        element.children(matching: .textField).element(boundBy: 2).tap()
        XCUIDevice.shared.orientation = .faceUp
        
        let suggestionElement2 = app/*@START_MENU_TOKEN@*/.otherElements["Typing Predictions"]/*[[".keyboards.otherElements[\"Typing Predictions\"]",".otherElements[\"Typing Predictions\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).matching(identifier: "suggestion").element(boundBy: 0)
        suggestionElement2.tap()
        XCUIDevice.shared.orientation = .portrait
        element.children(matching: .textField).element(boundBy: 3).tap()
        XCUIDevice.shared.orientation = .faceUp
        suggestionElement2.tap()
        XCUIDevice.shared.orientation = .portrait
        element.children(matching: .secureTextField).element(boundBy: 0).tap()
        XCUIDevice.shared.orientation = .faceUp
        
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"more, numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        element.children(matching: .secureTextField).element(boundBy: 1).tap()
        moreKey.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .portrait
        app/*@START_MENU_TOKEN@*/.keys["6"]/*[[".keyboards.keys[\"6\"]",".keys[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        signUpButton.tap()
        XCUIDevice.shared.orientation = .faceUp
        app.alerts["Password Incorrect"].buttons["OK"].tap()
        XCUIDevice.shared.orientation = .portrait
        XCUIDevice.shared.orientation = .faceUp
        
    }
    
    func testViewPeopleAndCancelAdd(){
        
        let app = XCUIApplication()
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"eyeDoor.LoginView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.children(matching: .textField).element.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        tKey.tap()
        
        app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["g"]/*[[".keyboards.keys[\"g\"]",".keys[\"g\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let lKey = app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        lKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        mKey.tap()
        element.children(matching: .secureTextField).element.tap()
        tKey.tap()
        eKey.tap()
        sKey.tap()
        XCUIDevice.shared.orientation = .portrait
        tKey.tap()
        loginButton.tap()
        XCUIDevice.shared.orientation = .faceUp
        
        let menuButton = app.navigationBars["Home"].buttons["Menu"]
        menuButton.tap()
        app.buttons["My People"].tap()
        
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Austin").element.tap()
        app.navigationBars["Austin Sizemore"].buttons["Back"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Ian").element.tap()
        app.navigationBars["Ian Smith"].buttons["Back"].tap()
        
        let myPeopleNavigationBar = app.navigationBars["My People"]
        myPeopleNavigationBar.buttons["Add"].tap()
        app.navigationBars["Add New Person"].buttons["Cancel"].tap()
        myPeopleNavigationBar.buttons["Home"].tap()
        menuButton.tap()
        app.buttons["Account"].tap()
        app.buttons["Logout"].tap()
        
    }

}
