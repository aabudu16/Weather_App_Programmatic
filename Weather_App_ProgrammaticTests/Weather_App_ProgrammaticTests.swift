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
    
    func testLoadWeather () {
        let data = weatherMODEL()
        
        let weather = WeatherModel.getWeatherDataTest(from: data)
        XCTAssert(weather.count != 0)
    }

    private func weatherMODEL() -> Data {
        //let bundle = Bundle(for: type(of: self))
        guard let pathToData = Bundle.main.path(forResource: "weatherJSON", ofType: "json")  else {
            XCTFail("error deparsing")
       return Data()
            
        }
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch let error {
            fatalError("couldn't find data \(error)")
        }
    }
    
}

