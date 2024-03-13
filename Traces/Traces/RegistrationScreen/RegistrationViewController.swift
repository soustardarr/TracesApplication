//
//  RegistrationViewController.swift
//  Traces
//
//  Created by Ruslan Kozlov on 11.03.2024.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController, UINavigationControllerDelegate {

    private var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView(image: .photo)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 100
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
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

    private var nameTextField: UITextField = {
        let loginTextField = UITextField()
        loginTextField.keyboardType = .emailAddress
        loginTextField.placeholder = "твой никнейм..."
        loginTextField.autocorrectionType = .no
        loginTextField.autocapitalizationType = .none
        loginTextField.returnKeyType = .continue
        loginTextField.borderStyle = .roundedRect
        return loginTextField
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
        passwordTextField.returnKeyType = .continue
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()

    private var secondPasswordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.keyboardType = .default
        passwordTextField.placeholder = "пароль второй раз..."
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .done
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()


    private var doneSignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("готово", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(doneSignUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()



    @objc func doneSignUpButtonTapped() {

        nameTextField.resignFirstResponder()
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        secondPasswordTextField.resignFirstResponder()

        guard let name = nameTextField.text,
              let login = loginTextField.text,
              let password = passwordTextField.text,
              let secondPassword = secondPasswordTextField.text,
              !login.isEmpty,
              !password.isEmpty,
              !secondPassword.isEmpty,
              !name.isEmpty,
              password == secondPassword,
              password.count >= 6,
              name.count >= 3
        else {
            alertUserLoginError()
            return
        }

        DataBaseManager.shared.userExists(with: login) { [ weak self ] exists in
            guard let strongSelf = self else { return }
            guard !exists else {
                strongSelf.alertUserLoginError(message: "пользоваетль с таким email сущевствует")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: login, password: password) { dataResult, error in
                guard dataResult != nil, error == nil else { return }
                DataBaseManager.shared.InsertUser(with: TracesUser(name: name, email: login))
                strongSelf.navigationController?.popViewController(animated: true)
            }

        }
        
    }

    private func alertUserLoginError(message: String = "введите корректную информацию") {
        let alertController = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ок", style: .cancel))
        present(alertController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        loginTextField.delegate = self
        passwordTextField.delegate = self
        secondPasswordTextField.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePhoto))
        avatarImageView.addGestureRecognizer(gesture)
        setupUI()

    }

    @objc func didTapChangeProfilePhoto() {
        presentAlertCameraOrPhoto()
    }

    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(avatarImageView)
        fieldStackView.addArrangedSubview(nameTextField)
        fieldStackView.addArrangedSubview(loginTextField)
        fieldStackView.addArrangedSubview(passwordTextField)
        fieldStackView.addArrangedSubview(secondPasswordTextField)
        view.addSubview(fieldStackView)
        view.addSubview(doneSignUpButton)


        NSLayoutConstraint.activate([

            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200),

            fieldStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 50),
            fieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            fieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            doneSignUpButton.topAnchor.constraint(equalTo: fieldStackView.bottomAnchor, constant: 40),
            doneSignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneSignUpButton.widthAnchor.constraint(equalToConstant: 150),
            doneSignUpButton.heightAnchor.constraint(equalToConstant: 50)

        ])


    }

}


extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            loginTextField.becomeFirstResponder()
        } else if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            secondPasswordTextField.becomeFirstResponder()
        } else if secondPasswordTextField == textField {
            doneSignUpButtonTapped()
        }
        return true
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate {

    func presentAlertCameraOrPhoto() {
        let controller = UIAlertController(title: "Фото профиля",
                                           message: "сделать фото или выбрать из галереи",
                                           preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "из галереи", style: .default, handler: { [ weak self ] _ in
            self?.presentPicker()
        }))
        controller.addAction(UIAlertAction(title: "открыть камеру", style: .default, handler: { [ weak self ] _ in
            self?.presentCamera()
        }))
        controller.addAction(UIAlertAction(title: "отмена", style: .cancel))
        present(controller, animated: true)
    }

    func presentPicker() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        self.present(vc, animated: true)
    }

    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let photo = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true)
            avatarImageView.image = photo
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}
