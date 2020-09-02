//
//  PassportTests.swift
//  Yandex MusicTests
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import XCTest
@testable import Yandex_Music

class PassportTests: XCTestCase {
    private let passportService: AuthServiceProtocol = AuthService()

    // MARK:

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetTrackIdWithCorrectLogin() throws {
        let trackIdExpectation = expectation(description: "trackId")

        let login = TestConstants.API.correctLogin
        var receivedTrackId: String?

        passportService.start(login: login) { (result) in
            switch result {
            case .success(let trackId):
                receivedTrackId = trackId
            case .failure(_):
                receivedTrackId = nil
            }
            trackIdExpectation.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(receivedTrackId)
        }
    }

    func testGetTrackIdWithWrongLogin() throws {
        let trackIdExpectation = expectation(description: "trackId")

        let wrongLogin = TestConstants.API.wrongLogin
        var passportError: PassportError?

        passportService.start(login: wrongLogin) { (result) in
            switch result {
            case .success(_):
                passportError = nil
            case .failure(let error):
                passportError = error as? PassportError
            }
            trackIdExpectation.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            XCTAssertTrue(passportError == .accountNotFound)
        }
    }

    func testAuthWithCorrectPassword() throws {
        let authExpectation = expectation(description: "auth")

        let login = TestConstants.API.correctLogin
        let password = TestConstants.API.password
        var authUser: User?

        passportService.start(login: login) { (startResult) in
            switch startResult {
            case .success(let trackId):

                self.passportService.auth(trackId: trackId, password: password) { (authResult) in
                    switch authResult {
                    case .success(let user):
                        authUser = user
                    case .failure(_):
                        authUser = nil
                    }
                    authExpectation.fulfill()
                }

            case .failure(_):
                authUser = nil
                authExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(authUser)
        }
    }
}
