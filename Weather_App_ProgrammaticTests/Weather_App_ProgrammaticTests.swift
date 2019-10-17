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

    private func weatherMODEL() -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let pathToData = bundle.path(forResource: "weatherJSON", ofType: "json")  else {
            XCTFail("couldn't find Json")
            return nil
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            fatalError("couldn't find data \(error)")
        }
    }
    func testLoadWeather () {
        let data = weatherMODEL() ?? Data()
        let weather = WeatherModel.getWeatherDataTest(from: data) ?? []
        XCTAssertTrue(weather.count > 0, "No weather was loaded")
    }
}

