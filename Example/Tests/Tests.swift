//import XCTest
//import FirebaseHelper
//
//class Tests: XCTestCase {
//    func testDecrement() {
//        let expectation = self.expectation(description: #function)
//        defer { waitForExpectations(timeout: 10) }
//
//        let rand1 = Int(arc4random_uniform(500))
//        let rand2 = Int(arc4random_uniform(500))
//        FirebaseHelper.main.set(rand1, at: "test") { (error) in
//            XCTAssertNil(error, String(describing: error))
//            let work = GroupWork()
//            for _ in 1...rand2 {
//                work.start()
//                FirebaseHelper.main.increment(-1, at: "test") { (error) in
//                    XCTAssertNil(error, String(describing: error))
//                    work.finish(withResult: true)
//                }
//            }
//            work.allDone {
//                FirebaseHelper.main.get("test") { (result) in
//                    switch result {
//                    case .failure(let error):
//                        XCTFail(String(describing: error))
//                        expectation.fulfill()
//                    case .success(let data):
//                        XCTAssertEqual(data.value as? Int, rand1 - rand2)
//                        expectation.fulfill()
//                    }
//                }
//            }
//        }
//    }
//
//    func testGetSetDelete() {
//        let expectation = self.expectation(description: #function)
//        defer { waitForExpectations(timeout: 10) }
//
//        FirebaseHelper.main.set("a", at: "test") { (error) in
//            XCTAssertNil(error, String(describing: error))
//
//            FirebaseHelper.main.get("test") { (result) in
//                switch result {
//                case .failure(let error):
//                    XCTFail(String(describing: error))
//                    expectation.fulfill()
//                case .success(let data):
//                    XCTAssertEqual(data.value as? String, "a")
//
//                    FirebaseHelper.main.delete("test") { (error) in
//                        XCTAssertNil(error, String(describing: error))
//
//                        FirebaseHelper.main.get("test") { (result) in
//                            switch result {
//                            case .failure(let error):
//                                XCTFail(String(describing: error))
//                                expectation.fulfill()
//                            case .success(let data):
//                                XCTAssertFalse(data.exists())
//                                expectation.fulfill()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    func testIncrement() {
//        let expectation = self.expectation(description: #function)
//        defer { waitForExpectations(timeout: 10) }
//
//        FirebaseHelper.main.increment(1, at: "test") { (error) in
//            XCTAssertNil(error, String(describing: error))
//
//            FirebaseHelper.main.get("test") { (result) in
//                switch result {
//                case .failure(let error):
//                    XCTFail(String(describing: error))
//                    expectation.fulfill()
//                case .success(let data):
//                    XCTAssertEqual(data.value as? Int, 1)
//                    expectation.fulfill()
//                }
//            }
//        }
//    }
//
//    func testIncrementConcurrent() {
//        let expectation = self.expectation(description: #function)
//        defer { waitForExpectations(timeout: 10) }
//
//        let incrementsDone = DispatchGroup()
//        for _ in 1...2 {
//            incrementsDone.enter()
//            FirebaseHelper.main.increment(1, at: "test") { (error) in
//                XCTAssertNil(error, String(describing: error))
//                incrementsDone.leave()
//            }
//        }
//        incrementsDone.notify(queue: .main) {
//            FirebaseHelper.main.get("test") { (result) in
//                switch result {
//                case .failure(let error):
//                    XCTFail(String(describing: error))
//                    expectation.fulfill()
//                case .success(let data):
//                    XCTAssertEqual(data.value as? Int, 2)
//                    expectation.fulfill()
//                }
//            }
//        }
//    }
//
//    func testMakeDatabaseReference() {
//        do {
//            _ = try FirebaseHelper.main.makeReference("a")
//            _ = try FirebaseHelper.main.makeReference("a", "b")
//            _ = try FirebaseHelper.main.makeReference("/a/")
//            _ = try FirebaseHelper.main.makeReference("//a//")
//            _ = try FirebaseHelper.main.makeReference("/a/a/")
//        } catch {
//            XCTFail()
//        }
//    }
//
//    func testMakeDatabaseReferenceFail() {
//        XCTAssertThrowsError(_ = try FirebaseHelper.main.makeReference(""))
//        XCTAssertThrowsError(_ = try FirebaseHelper.main.makeReference("a", ""))
//        XCTAssertThrowsError(_ = try FirebaseHelper.main.makeReference("", "a"))
//        XCTAssertThrowsError(_ = try FirebaseHelper.main.makeReference("/"))
//        XCTAssertThrowsError(_ = try FirebaseHelper.main.makeReference("//"))
//        XCTAssertThrowsError(_ = try FirebaseHelper.main.makeReference("///"))
//        XCTAssertThrowsError(_ = try FirebaseHelper.main.makeReference("/a//a/"))
//    }
//}

