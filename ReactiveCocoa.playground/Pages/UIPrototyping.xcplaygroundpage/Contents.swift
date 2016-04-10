//: [Back to home](Intro)

import UIKit
import XCPlayground
import ReactiveCocoa

final class MyControllerViewModel {
    let loginAction = Services.login
}

final class MyController: UIViewController {
    lazy var loginTextField: UITextField = UITextField()
    lazy var passwordTextField: UITextField = UITextField()
    lazy var loginButton: UIButton = UIButton(type: .System)
    
    let viewModel = MyControllerViewModel()
    
    lazy var cocoaAction = CocoaAction(self.viewModel.loginAction) { _ in
        (username: self.loginTextField.text ?? "",
         password: self.passwordTextField.text ?? "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(cocoaAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        
        viewModel.loginAction.values.observeNext { next in
            print("next screen \(next)")
        }
    }
}


























// ----- hidden code

extension MyController {
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .whiteColor()
        
        [loginTextField, passwordTextField, loginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        loginTextField.borderStyle = .RoundedRect
        passwordTextField.borderStyle = .RoundedRect
        loginButton.setTitle("LOGIN", forState: .Normal)
        
        NSLayoutConstraint.activateConstraints([
            loginTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            loginTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.9),
            loginTextField.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 25),
            passwordTextField.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            passwordTextField.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 0.9),
            passwordTextField.topAnchor.constraintEqualToAnchor(loginTextField.bottomAnchor, constant: 8),
            loginButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            loginButton.topAnchor.constraintEqualToAnchor(passwordTextField.bottomAnchor, constant: 8),
            ])
    }
}

enum Services {
    static var login: Action<(username: String, password: String), LoginResponse, NSError> {
        return Action { username, password in
            if username == "bob" && password == "pass" {
                return SignalProducer(value: LoginResponse(accessToken: "abc"))
                    .delay(1.5, onScheduler: QueueScheduler.mainQueueScheduler)
            } else {
                return SignalProducer.empty
                    .delay(1.5, onScheduler: QueueScheduler.mainQueueScheduler)
            }
        }
    }
}

// start live preview

XCPlaygroundPage.currentPage.liveView = MyController()
