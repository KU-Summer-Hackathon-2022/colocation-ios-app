//
//  AuthViewController.swift
//  colocation-ios-app
//
//  Created by Hamlit Jason on 2022/08/19.
//

import UIKit
import FirebaseAuth
import SnapKit
import RxSwift
import RxCocoa

class AuthViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let emailField = UITextField()
    let passwordFiled = UITextField()
    let signupButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmailField()
        setupPasswordField()
        setupSignupButton()
        
        bind()
    }
    
    func bind() {
        signupButton.rx.tap
            .debug("안녕하세요.")
            .bind { [weak self] in
                guard let self = self else { return }
                self.signUp()
            }
            .disposed(by: disposeBag)
    }
    
    private func signUp() {
        // 이메일과 패스워드 가지고 진행
        let alertController = UIAlertController(
            title: nil,
            message: "🥳 환영합니다. ",
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(
            title: "OK",
            style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
}

extension AuthViewController {
    private func setupEmailField() {
        view.addSubview(emailField)
        
        emailField.placeholder = "👨‍🎨 나만의 개성 넘치는 이메일을 입력해주세요."
        emailField.borderStyle = .roundedRect
        emailField.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupPasswordField() {
        view.addSubview(passwordFiled)
        
        passwordFiled.placeholder = "🛡 안전한 비밀번호를 입력해주세요."
        passwordFiled.borderStyle = .roundedRect
        passwordFiled.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(10)
            $0.leading.equalTo(emailField.snp.leading)
            $0.trailing.equalTo(emailField.snp.trailing)
        }
    }
    
    private func setupSignupButton() {
        view.addSubview(signupButton)
        
        signupButton.setTitle("✨ 회원가입 ✨", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.layer.borderColor = .init(gray: 1.0, alpha: 1.0)
        signupButton.layer.borderWidth = 1.5
        signupButton.clipsToBounds = true
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(passwordFiled.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
    }
}

