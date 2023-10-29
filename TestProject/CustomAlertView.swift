//
//  CustomAlertView.swift
//  TestProject
//
//  Created by Chun-Li Cheng on 2023/10/18.
//

//import Foundation
import UIKit

class CustomAlertView: UIView {
    
    private struct Constants {
        static let alertWidthMultiplier: CGFloat = 356 / UIScreen.main.bounds.width
        static let alertHeightMultiplier: CGFloat = 318 / 356
        static let buttonLeadingTrailingPadding: CGFloat = 37
        static let titleLabelLeadingTrailingPadding: CGFloat = 55
    }
    
//    private let alertViewConerRadius: CGFloat = 15
    
//    var titleLabel = UILabel()
//    var closeButton = UIButton()
//    var confirmButton = UIButton()
//    var cancelButton = UIButton()
    var alertView: UIView!
    var confirmAction: (() -> Void)?
    var closeAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setupUI() {
        // Custom Alert View
        alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 15
        alertView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
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
        
        let closeButton = UIButton(type: .system)
        let image = UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal)
        closeButton.setImage(image, for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let confirmButton = UIButton(type: .system)
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
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        let cancelButton = UIButton(type: .system)
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
        cancelButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        self.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(closeButton)
        alertView.addSubview(confirmButton)
        alertView.addSubview(cancelButton)

        // AutoLayout Constraints
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alertView.widthAnchor.constraint(
                equalTo: self.widthAnchor, multiplier: Constants.alertWidthMultiplier),
            alertView.heightAnchor.constraint(
                equalTo: alertView.widthAnchor, multiplier: Constants.alertHeightMultiplier),
            closeButton.topAnchor.constraint(
                equalTo: alertView.topAnchor, constant: 18),
            closeButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor, constant: -22),
            titleLabel.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor,
                constant: Constants.titleLabelLeadingTrailingPadding),
            titleLabel.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor,
                constant: -Constants.titleLabelLeadingTrailingPadding),
            confirmButton.bottomAnchor.constraint(
                equalTo: cancelButton.topAnchor, constant: -10),
            confirmButton.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor,
                constant: Constants.buttonLeadingTrailingPadding),
            confirmButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor,
                constant: -Constants.buttonLeadingTrailingPadding),
            cancelButton.topAnchor.constraint(
                equalTo: confirmButton.bottomAnchor, constant: 16),
            cancelButton.bottomAnchor.constraint(
                equalTo: alertView.bottomAnchor, constant: -53),
            cancelButton.leadingAnchor.constraint(
                equalTo: alertView.leadingAnchor,
                constant: Constants.buttonLeadingTrailingPadding),
            cancelButton.trailingAnchor.constraint(
                equalTo: alertView.trailingAnchor,
                constant: -Constants.buttonLeadingTrailingPadding),
            cancelButton.heightAnchor.constraint(equalTo: confirmButton.heightAnchor)
        ])
    }
    
    @objc func closeTapped() {
        closeAction?()
    }
    
    @objc func confirmTapped() {
        confirmAction?()
    }
    
}

