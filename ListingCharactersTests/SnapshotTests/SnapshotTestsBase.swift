//
//  SnapshotTestsBase.swift
//  ListingCharactersTests
//
//  Created by Jarbas on 10/12/20.
//

import XCTest
@testable import ListingCharacters
import SnapshotTesting
import SwiftUI

class SnapshotTestsBase: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    var defaultDevices: [(name: String, device: ViewImageConfig)] {
        [
            ("SE", .iPhoneSe),
            ("X", .iPhoneX)
        ]
    }

    func assertSnapshotDevices<V: View>(
        _ view: V,
        devices: [(name: String, device: ViewImageConfig)]? = nil,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        (devices ?? defaultDevices).forEach {
            let viewController = UIHostingController(rootView: view)

            assertSnapshot(
                matching: viewController,
                as: .image(on: $0.device),
                file: file,
                testName: "\(testName)-\($0.name)",
                line: line
            )
        }
    }
}
