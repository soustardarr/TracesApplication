//
//  AuthorizationViewController.swift
//  Traces
//
//  Created by Ruslan Kozlov on 11.03.2024.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private var logoImageView: UIImageView = {
        let image = UIImageView(image: .logoWhite)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var fieldStackView: UIStackView = {
        let fieldStackView = UIStackView()
        fieldStackView.axis = .vertical
        fieldStackView.spacing = 10
        fieldStackView.alignment = .fill
        fieldStackView.distribution = .fillEqually
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        return fieldStackView
    }()

    private var loginTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.keyboardType = .emailAddress
        loginTextField.placeholder = "email..."
        loginTextField.autocorrectionType = .no
        loginTextField.autocapitalizationType = .none
        loginTextField.returnKeyType = .continue
        loginTextField.borderStyle = .roundedRect
        return loginTextField
    }()

    private var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.keyboardType = .default
        passwordTextField.placeholder = "пароль..."
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()

    private var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var orLabel: UILabel = {
        let orLabel = UILabel()
        orLabel.text = "или"
        orLabel.textColor = .white
        orLabel.font = UIFont.systemFont(ofSize: 30)
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        return orLabel
    }()

    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("регистрация", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(didTapRegister), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func didTapRegister() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: false)
    }

    @objc func logInButtonTapped() {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              !login.isEmpty,
              !password.isEmpty,
              password.count >= 6
        else {
            alertUserLoginError()
            return
        }

        //firebase login
    }

    private func alertUserLoginError() {
        
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()

        let alertController = UIAlertController(title: "Ошибка!", message: "введите всю информацию для входа", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ок", style: .cancel))
        present(alertController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()

    }

    private func setupUI() {
        self.title = "Авторизация"
        view.backgroundColor = .black
        view.addSubview(logoImageView)
        fieldStackView.addArrangedSubview(loginTextField)
        fieldStackView.addArrangedSubview(passwordTextField)
        fieldStackView.addArrangedSubview(logInButton)
        view.addSubview(fieldStackView)
        view.addSubview(orLabel)
        view.addSubview(signUpButton)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            fieldStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            fieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.topAnchor.constraint(equalTo: fieldStackView.bottomAnchor, constant: 40),

            signUpButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 40),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 150),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)

        ])


    }

}


extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            logInButtonTapped()
        }
        return true
    }
}
