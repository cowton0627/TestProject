//
//  ViewController.swift
//  TestProject
//
//  Created by Chun-Li Cheng on 2023/10/16.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: view.bounds)
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    var alertView: UIView!

    @IBOutlet weak var operationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operationBtn.setTitle("操作", for: .normal)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        showCustomAlert {
            self.confirm()
        } close: {
            self.close()
        }
        
//        showCustomAlert()
        
        
//        let alert = UIAlertController(title: "溫馨提醒",
//                                      message: "您即將離開操作",
//                                      preferredStyle: .alert)
//        let confirmAct = UIAlertAction(title: "確認", style: .default) { _ in
//            print("confirm")
//        }
//        let cancelAct = UIAlertAction(title: "取消", style: .cancel) { _ in
//            print("cancel")
//        }
//        alert.addAction(confirmAct)
//        alert.addAction(cancelAct)
//        self.present(alert, animated: true)
        
        
//        let alert = ReusableAlertViewController()
//        present(alert, animated: true)
        
//        let alert = ReusableAlertView.instantiateFromNib()
//        alert.delegate = self
//        alert.center = view.center
//        alert.setupTitleLabel(title: "溫馨提醒",
//                              subtitle: "敬請期待",
//                              lhsText: .cancel,
//                              rhsText: .confirm)
//        view.addSubview(backgroundView)
//        view.addSubview(alert)
    }
    
    // MARK: - 原有的 Function works fine
    func showCustomAlert() {
        // Background dim view
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.tag = 100 // We'll use this tag to remove it later
        self.view.addSubview(backgroundView)

        // Custom Alert View
        alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 15
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "Vector"), for: .normal)
//        closeButton.setTitle("X", for: .normal)
//        closeButton.setTitleColor(.black, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self,
                              action: #selector(closeAlert),
                              for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
//        titleLabel.text = "Are you sure you want to turn off ZAP?"
//        titleLabel.setTitleColor(.black, for: .normal)
        let titleString = "Are you sure you want to turn off ZAP?"
        let attributedTitleString = NSAttributedString(string: titleString,
                                                       attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
            ])
        titleLabel.attributedText = attributedTitleString
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let cancelButton = UIButton()
//        cancelButton.setTitle("Cancel", for: .normal)
//        cancelButton.setTitleColor(.black, for: .normal)
        let cancelString = "Cancel"
        let attributedCancelString = NSAttributedString(string: cancelString,
                                                       attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
            ])
        cancelButton.setAttributedTitle(attributedCancelString, for: .normal)
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self,
                               action: #selector(closeAlert),
                               for: .touchUpInside)

        let confirmButton = UIButton()
//        confirmButton.setTitle("Yes, Stop ZAP", for: .normal)
        confirmButton.backgroundColor = .brown
        let confirmString = "Yes, Stop ZAP"
        let attributedConfirmString = NSAttributedString(string: confirmString,
                                                       attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
            ])
        confirmButton.setAttributedTitle(attributedConfirmString, for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.setTitleColor(.black, for: .highlighted)
//        confirmButton.layer.cornerRadius = 5
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.addTarget(self,
                                action: #selector(confirmTapped),
                                for: .touchUpInside)

        backgroundView.addSubview(alertView)
        alertView.addSubview(closeButton)
        alertView.addSubview(titleLabel)
        alertView.addSubview(confirmButton)
        alertView.addSubview(cancelButton)
        // AutoLayout Constraints
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
//            alertView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 37),
//            alertView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -37),
//            alertView.widthAnchor.constraint(equalToConstant: 356),
//            alertView.heightAnchor.constraint(equalToConstant: 318),
            alertView.widthAnchor.constraint(
                equalTo: backgroundView.widthAnchor,
                multiplier: 356/UIScreen.main.bounds.width),
            alertView.heightAnchor.constraint(
                equalTo: alertView.widthAnchor,multiplier: 318/356),
            
            titleLabel.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor, constant: 55),
            titleLabel.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor, constant: -55),
            
            closeButton.topAnchor.constraint(
                equalTo: alertView.topAnchor, constant: 18),
            closeButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor, constant: -22),
            
//            confirmButton.bottomAnchor.constraint(
//                equalTo: cancelButton.topAnchor, constant: -10),
            confirmButton.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor, constant: 37),
            confirmButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor, constant: -37),
            cancelButton.topAnchor.constraint(
                equalTo: confirmButton.bottomAnchor, constant: 16),
            cancelButton.bottomAnchor.constraint(
                equalTo: alertView.bottomAnchor, constant: -53),
            cancelButton.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor, constant: 37),
            cancelButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor, constant: -37)
//            ,cancelButton.heightAnchor.constraint(equalTo: confirmButton.heightAnchor)
        ])

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeAlert))
//        backgroundView.addGestureRecognizer(tapGesture)

        // Presentation animation
        alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
                self.alertView.transform = .identity
                self.alertView.alpha = 1
            }, completion: nil)
//        UIView.animate(withDuration: 0.25) {
//            alertView.transform = .identity
//            alertView.alpha = 1
//        }
    }
    
    @objc func closeAlert() {
//        self.view.viewWithTag(100)?.removeFromSuperview()
        if let backgroundView = self.view.viewWithTag(100) {
            UIView.animate(withDuration: 0.25,
                           animations: {
                backgroundView.alpha = 0
            }) { _ in
                backgroundView.removeFromSuperview()
            }
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7,
//                           initialSpringVelocity: 0, options: .curveEaseInOut,
//                           animations: {
//                backgroundView.alpha = 0
//                backgroundView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
//            }) { _ in
//                backgroundView.removeFromSuperview()
//            }
        }
        print("objc close/cancel tapped.")
    }
    
    @objc func confirmTapped()  {
        print("objc confirm tapped")
    }
    
    
    func close() {
        print("close/cancel tapped.")
    }
    
    func confirm()  {
        print("confirm tapped")
    }
}

extension ViewController: ReusableAlertViewDelegate {
    func buttonAction() {
        UIView.animate(withDuration: 0.25,
                       animations: {
            self.backgroundView.alpha = 0.5
        }) { _ in
            self.backgroundView.removeFromSuperview()
        }
    }
    
    func leftButtonAction() {
        print("left button tapped.")
    }
    
    func rightButtonAction() {
        print("right button tapped.")
    }
    
    
}

extension UIViewController {
    
    private struct Constants {
        static let backgroundViewTag: Int = 101
    }
    
    func showCustomAlert(confirm: @escaping () -> Void,
                         close: @escaping () -> Void) {
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.tag = Constants.backgroundViewTag
        self.view.addSubview(backgroundView)
        
        let alertView = CustomAlertView(frame: self.view.bounds)
        backgroundView.addSubview(alertView)
        
        alertView.confirmAction = {
            confirm()
            self.removeBackgroundView()
        }
        
        alertView.closeAction = {
            close()
            self.removeBackgroundView()
        }
        
        // Presentation animation
        alertView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)    // 變大
        alertView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0, options: .curveEaseInOut,
                       animations: {
            alertView.transform = .identity     // 回原大小
            alertView.alpha = 1
        }, completion: nil)
    }
    
    func removeBackgroundView() {
        if let backgroundView = self.view.viewWithTag(Constants.backgroundViewTag) {
            UIView.animate(withDuration: 0.25,
                           animations: {
                backgroundView.alpha = 0
            }) { _ in
                backgroundView.removeFromSuperview()
            }
        }
    }
}

