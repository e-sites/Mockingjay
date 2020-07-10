//
//  MockingjayTests.swift
//  MockingjayTests
//
//  Created by Kyle Fuller on 21/01/2015.
//  Copyright (c) 2015 Cocode. All rights reserved.
//

import Foundation
import XCTest
@testable import Mockingjay

func toString(_ item:AnyClass) -> String {
  return "\(item)"
}

class MockingjaySessionTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }

  func testEphemeralSessionConfigurationIncludesProtocol() {
    ensureMockingjayProtocolRegistration()
    let configuration = URLSessionConfiguration.ephemeral
    let protocolClasses = (configuration.protocolClasses!).map(toString)
    XCTAssertEqual(protocolClasses.first!, "MockingjayProtocol")
  }

  func testDefaultSessionConfigurationIncludesProtocol() {
    ensureMockingjayProtocolRegistration()
    let configuration = URLSessionConfiguration.default
    let protocolClasses = (configuration.protocolClasses!).map(toString)
    XCTAssertEqual(protocolClasses.first!, "MockingjayProtocol")
  }

  func testURLSession() {
    let expectation = self.expectation(description: "MockingjaySessionTests")

    let stubbedError = NSError(domain: "Mockingjay Session Tests", code: 0, userInfo: nil)
    stub(everything, failure(stubbedError))

    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)

    session.dataTask(with: URL(string: "https://httpbin.org/")!, completionHandler: { data, response, error in
      DispatchQueue.main.async {
        XCTAssertNotNil(error)
        XCTAssertEqual((error as NSError?)?.domain, "Mockingjay Session Tests")
        expectation.fulfill()
      }
    }) .resume()

    waitForExpectations(timeout: 5) { error in
      XCTAssertNil(error, String(describing: error))
    }
  }

  /// Ensures that `MockingjayProtocol` is added to `URLProtocol` registered classes.
  ///
  /// The registration process happens while stubbing, so for test cases, where `stub(_:_:)` is not called
  /// `MockingjayProtocol` will not be registered. Call this method within those test cases
  /// if your test relies on `MockingjayProtocol` being registered to pass.
  func ensureMockingjayProtocolRegistration() {
    if !registered {
      URLProtocol.registerClass(MockingjayProtocol.self)
      URLSessionConfiguration.mockingjaySwizzleDefaultSessionConfiguration()
      registered = true
    }
  }
}
