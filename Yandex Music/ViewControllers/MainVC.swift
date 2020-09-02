//
//  MainVC.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/2/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation
import AppKit

final class MainVC: NSViewController {

    // MARK: Helpers

    private func navigateToMainPage() {
        print("navigateToMainUserPage")
    }

    // MARK: IBActions

    @IBAction private func onLogInClicked(_ sender: NSButton) {
        let authVC = AuthVC()
        authVC.vm = AuthVM()
        authVC.delegate = self

        presentAsSheet(authVC)
    }
}

extension MainVC: AuthVCDelegate {

    func authVCDidFinishLoginWithSuccess(_ vc: AuthVC) {
        navigateToMainPage()
    }
}
