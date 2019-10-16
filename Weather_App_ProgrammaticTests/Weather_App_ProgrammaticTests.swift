//
//  Weather_App_ProgrammaticTests.swift
//  Weather_App_ProgrammaticTests
//
//  Created by Mr Wonderful on 10/11/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import XCTest
@testable import Weather_App_Programmatic

class Weather_App_ProgrammaticTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodingJson(){
        guard let pathToData = Bundle.main.path(forResource: "weatherJSON", ofType: "json") else {
            XCTFail("COuldnt Find json file")
        }
        let url = URL(fileURLWithPath: pathToData)
        
        do{
            data = try Data(contentsOf: url)
            let weather = try 
        }catch{
            
        }
    }
    

}
