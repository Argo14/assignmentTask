//
//  Assignment_taskUITests.swift
//  Assignment_taskUITests
//
//  Created by Arjun Gopakumar on 27/09/21.
//

import XCTest

class Assignment_taskUITests: XCTestCase {
    
    var app : XCUIApplication!

    override func setUpWithError() throws {
       
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    func testTableViewMovement(){
        
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Arturo "]/*[[".otherElements[\"Arturo \"].staticTexts[\"Arturo \"]",".staticTexts[\"Arturo \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Franklin Wood"]/*[[".otherElements[\"Franklin Wood\"].staticTexts[\"Franklin Wood\"]",".staticTexts[\"Franklin Wood\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.otherElements["Franklin Wood"].staticTexts["Franklin Wood"].tap()
        tablesQuery.otherElements["Arturo "].staticTexts["Arturo "].tap()
        
        let johnDuaneStaticText = tablesQuery.otherElements["John Duane"].staticTexts["John Duane"]
        johnDuaneStaticText.tap()
     
            
                        
    }
}
