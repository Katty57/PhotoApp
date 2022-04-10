//
//  ViewController.swift
//  PhotoApp
//
//  Created by  User on 09.04.2022.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    var loginView: UIView!
    var nicknameTextField: UITextField!
    var passwordTextField: UITextField!
//    var titleLabel: UILabel!
    var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI Elements
        loginView = UIView()
        loginView.backgroundColor = .white
        self.view.addSubview(loginView)
        
        passwordTextField = UITextField()
        passwordTextField.setUnderLinedTextField()
        passwordTextField.backgroundColor = .white
        passwordTextField.addTarget(self, action: #selector(doneEditing(_:)), for: .primaryActionTriggered)
        passwordTextField.placeholder = "Enter password"
        loginView.addSubview(passwordTextField)
        
        nicknameTextField = UITextField()
        nicknameTextField.setUnderLinedTextField()
        nicknameTextField.backgroundColor = .white
        nicknameTextField.addTarget(self, action: #selector(doneEditing(_:)), for: .primaryActionTriggered)
        nicknameTextField.placeholder = "Enter nickname"
        loginView.addSubview(nicknameTextField)
        
//        titleLabel = UILabel()
//        titleLabel.backgroundColor = .blue
//        titleLabel.text = "Sign UpLogin"
//        titleLabel.font = UIFont(name: "Arial", size: 25.0)
//        loginView.addSubview(titleLabel)
        
        loginButton = UIButton(type: .custom)
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.layer.cornerRadius = loginButton.frame.width / 2
        
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(loginBegin(parameter:)), for: .touchUpInside)
        loginView.addSubview(loginButton)
        
        //Constraints
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.6),
            passwordTextField.heightAnchor.constraint(equalTo: loginView.heightAnchor, multiplier: 0.05)
        ])
        
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nicknameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: loginView.frame.height - 20),
            nicknameTextField.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            nicknameTextField.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            nicknameTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
        ])
        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            titleLabel.bottomAnchor.constraint(equalTo: nicknameTextField.topAnchor, constant: nicknameTextField.frame.height - 20),
//            titleLabel.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
//            titleLabel.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
//            titleLabel.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
//        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: passwordTextField.frame.height + 20),
            loginButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            loginButton.heightAnchor.constraint(equalTo: loginView.heightAnchor, multiplier: 0.08)
        ])
        // Do any additional setup after loading the view.
    }

    @objc func loginBegin (parameter: UIButton){
        if let nickname = nicknameTextField.text, let password = passwordTextField.text {
            guard let _ = nickname.rangeOfCharacter(from: NSCharacterSet.letters) else {
                alertCreation(titleForAlert: "Wrong input!", messageForAlert: "Nickname should containt at least one letter", titleForButton: "OK")
                return
            }
            guard let _ = password.rangeOfCharacter(from: NSCharacterSet.alphanumerics) else {
                alertCreation(titleForAlert: "Wrong input!", messageForAlert: "Password should containt at least one letter", titleForButton: "OK")
                return
            }
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Account")
            let predicate = NSPredicate(format: "nickname = '\(String(describing: nickname))'")
            fetchRequest.predicate = predicate
            
            do{
                let object = try context.fetch(fetchRequest)
                if object.count <= 0 {
                    let account = Account(context: context)
                    account.nickname = nickname
                    account.password = password
                    UserDefaults.standard.set(true, forKey: "userIsLoggedIn")
                    ad.saveContext()
                } else {
                    let profile = object.first as! NSManagedObject
                    if profile.value(forKey: "password") as! String != password {
                        alertCreation(titleForAlert: "Wrong password", messageForAlert: "", titleForButton: "OK")
                        return
                    }
                    
                }
            }
            catch
            {
                print(error)
            }
            
            
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 120, height: 100)
        let vc = PhotoSceneCollectionViewController(collectionViewLayout: layout)
        vc.userNickname = nicknameTextField?.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func alertCreation (titleForAlert: String, messageForAlert: String, titleForButton: String) {
        let alertController = UIAlertController(title: titleForAlert, message: messageForAlert, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: titleForButton, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func doneEditing(_ sender: UITextField) {
        sender.endEditing(true)
    }
}

extension UITextField {
//    func addHiddenTyping () {
//        let eyeButton = UIButton(type: .custom)
//        changeButtonImage(button: eyeButton)
//        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
//        eyeButton.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
//        eyeButton.tintColor = .gray
//        self.rightView = eyeButton
//        self.rightViewMode = .always
//        eyeButton.addTarget(self, action: #selector(eyeButtonTapped(_:)), for: .touchUpInside)
//    }
    
    func setUnderLinedTextField () {
        let border = CALayer()
        border.frame = CGRect(origin: CGPoint(x: 0, y: self.frame.size.height - 1.0), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderColor = UIColor.gray.cgColor
        border.borderWidth = 1.0
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
