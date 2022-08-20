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
                
            }
            .disposed(by: disposeBag)
    }
    
    private func signUp() {
        // 이메일과 패스워드 가지고 진행
        
        
        
        
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

//함께하는 사회를 위한 서비스.
//노인과 청년이 함께하는 사회를 위한 서비스를 기획한 핫식스 팀의 리더 이건우입니다.
//
//저희는 고령화 시대에 발생하는 문제와 지금 저와 여러분처럼 학교에 다니시는 분들의 문제에 집중했습니다.
/*
 프랑스의 코르카시옹은 1인 고령세대의 거주 공간에 주거지 마련의 어려움을 겪는 청년세대를 입주시키는 정책입니다.
 
 홀로사는 어르신들은 고립과 고독 그리고 외로움을 해결하고
 , 청년들을 주거비용 문제와 어른들의 지혜를 습득할 수 있는
 서비스를 준비하고 있습니다.
 
 
 */
