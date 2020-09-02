//
//  AuthVC.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/2/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation
import AppKit

protocol AuthVCDelegate: class {
    func authVCDidFinishLoginWithSuccess(_ vc: AuthVC)
}

final class AuthVC: NSViewController {
    @IBOutlet private weak var userNameContainerView: NSView!
    @IBOutlet private weak var userNameTextField: NSTextField!
    @IBOutlet private weak var userNameProgressIndicator: NSProgressIndicator!
    @IBOutlet private weak var nextButton: NSButton!

    @IBOutlet private weak var passwordContainerView: NSView!
    @IBOutlet private weak var passwordTextField: NSTextField!
    @IBOutlet private weak var passwordProgressIndicator: NSProgressIndicator!
    @IBOutlet private weak var logInButton: NSButton!

    var vm: AuthVMProtocol!
    weak var delegate: AuthVCDelegate?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
    }

    // MARK: Helpers

    private func setupSelf() {
        title = "Log in"

        setupTextFields()
    }

    private func setupTextFields() {
        #if DEBUG
        userNameTextField.stringValue = Constants.MyTestData.userName
        passwordTextField.stringValue = Constants.MyTestData.password
        #endif

        userNameTextField.target = self
        userNameTextField.action = #selector(onUserNameEnterPressed(_:))

        passwordTextField.target = self
        passwordTextField.action = #selector(onPasswordEnterPressed)

        concealPassword()
    }

    private func concealPassword() {
        nextButton.isHidden = false
        passwordContainerView.isHidden = true
        logInButton.isHidden = true
    }

    private func revealPassword() {
        nextButton.isHidden = true
        passwordContainerView.isHidden = false
        logInButton.isHidden = false
    }

    private func enterUserName() {
        userNameProgressIndicator.startAnimation(self)

        vm.enterUserName(userNameTextField.stringValue) { [weak self] (error) in
            self?.userNameProgressIndicator.stopAnimation(self)

            if let error = error {
                NSAlert(error: error).runModal()
            } else {
                self?.revealPassword()
                self?.passwordTextField.becomeFirstResponder()
            }
        }
    }

    private func enterPassword() {
        passwordProgressIndicator.startAnimation(self)

        vm.enterPassword(passwordTextField.stringValue) { [weak self] (result) in
            self?.passwordProgressIndicator.stopAnimation(self)

            switch result {
            case .success(let user):
                self?.showGreetingAlert(for: user)
            case .failure(let error):
                NSAlert(error: error).runModal()
            }
        }
    }

    private func showGreetingAlert(for user: User) {
        let alert = NSAlert()
        alert.window.identifier = NSUserInterfaceItemIdentifier(rawValue: "GreetingAlert")
        alert.alertStyle = .informational
        alert.messageText = "\(user.firstname), welcome to Yandex Music MacOS client."
        let button = alert.addButton(withTitle: "Ok")
        button.target = self
        button.action = #selector(dismissAfterSuccessfulLogin(_:))
        alert.runModal()
    }

    private func hideGreetingAlert() {
        if NSApp.modalWindow?.identifier == NSUserInterfaceItemIdentifier(rawValue: "GreetingAlert") {
            NSApp.abortModal()
        }
    }

    @objc private func dismissAfterSuccessfulLogin(_ sender: NSButton) {
        hideGreetingAlert()
        delegate?.authVCDidFinishLoginWithSuccess(self)
        dismiss(sender)
    }

    // MARK: Actions

    @objc private func onUserNameEnterPressed(_ sender: NSTextField) {
        enterUserName()
    }

    @objc private func onPasswordEnterPressed(_ sender: NSTextField) {
        enterPassword()
    }

    // MARK: IBActions

    @IBAction private func onNextClicked(_ sender: NSButton) {
        enterUserName()
    }

    @IBAction private func onLogInClicked(_ sender: NSButton) {
        enterPassword()
    }
}

