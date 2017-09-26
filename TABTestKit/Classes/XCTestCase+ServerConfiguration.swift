//
//  XCTestCase+ServerConfiguration.swift
//  TABTestKit
//
//  The MIT License (MIT)
//
//  Created by Zachary Borrelli on 14/09/2017.
//  Copyright © 2017 The App Business LTD. All rights reserved.
//

import XCTest

public class Server {
  
  /**
   Configures the mock server to return the specified file and error code for a specific endpoint
   
   - parameter endpoint:     Endpoint that's supposed to be configured (e.g. /search/place)
   - parameter jsonFileName: Name of the JSON file that's supposed to be returned
   - parameter errorCode:    Error code that's supposed to be returned (e.g. 400, 500)
   */
  static func configure(endpoint: String, newJsonFileName: String? = nil, errorCode: Int = 200, file: StaticString = #file, lineNumber: UInt = #line) {
    let requestURL = createServerConfigurationURL(endpoint, newJsonFileName: newJsonFileName, errorCode: errorCode, file: file, lineNumber: lineNumber)
    sendServerRequest(requestURL, file: file, line: lineNumber)
  }
  
  /**
   Reset the mock server to how it was before any tests or configurations ran
   */
  static func reset(_ file: StaticString = #file, line: UInt = #line) {
    let resetURLString = "http://localhost:8081/reset"
    guard let resetURL = URL(string: resetURLString) else {
      XCTFail("Could not create reset URL")
      return
    }
    sendServerRequest(resetURL, file: file, line: line)
  }
  
  private static func createServerConfigurationURL(_ endpoint: String, newJsonFileName: String?, errorCode: Int, file: StaticString = #file, lineNumber: UInt = #line) -> URL {
    var components = URLComponents()
    components.scheme = "http"
    components.host = "localhost"
    components.port = 8081
    components.path = "/configure/\(endpoint)"
    var queryItems = [URLQueryItem]()
    if let fileName = newJsonFileName {
      queryItems.append(URLQueryItem(name: "newJsonFileName", value: fileName))
    }
    queryItems.append(URLQueryItem(name: "errorCode", value: "\(errorCode)"))
    components.queryItems = queryItems
    guard let url = components.url else {
      XCTFail("Server did timeout", file: file, line: lineNumber)
      fatalError()
    }
    return url
  }
  
  private static func sendServerRequest(_ url: URL, file: StaticString, line: UInt) {
    var request = NSMutableURLRequest(url: url) as URLRequest
    request.httpMethod = "POST"
    let session = URLSession.shared
    let group = DispatchGroup()
    group.enter()
    session.dataTask(with: request, completionHandler: {data, task, error in
      if let error = error {
        XCTFail(error.localizedDescription, file: file, line: line)
      }
      group.leave()
    }) .resume()
    let timeoutTime = DispatchTime.now() + 5
    guard case .success = group.wait(timeout: timeoutTime) else {
      XCTFail("Server did timeout", file: file, line: line)
      return
    }
  }
}
