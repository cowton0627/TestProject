//
//  ReusableAlertView.swift
//  TestProject
//
//  Created by Chun-Li Cheng on 2023/10/27.
//

import UIKit

protocol ReusableAlertViewDelegate: AnyObject {
    func buttonAction()
    func leftButtonAction()
    func rightButtonAction()
}

// 可重複使用的 AlertView
class ReusableAlertView: UIView {
    
    enum AlertButtonTitle: String {
        case confirm = "確認"
        case cancel = "取消"
    }
    
    // MARK: - Properties
    private let themeColor = #colorLiteral(red: 0.3764705882, green: 0.6823529412, blue: 0.7607843137, alpha: 1)
    private let titleColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
    
    weak var delegate: ReusableAlertViewDelegate?

    // MARK: - IBOutlet
    @IBOutlet weak var bottomView: CustomBottomView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var dividerView: UIView!
    
    // MARK: - class func
    class func instantiateFromNib() -> ReusableAlertView {
        guard let view = UINib(nibName: "\(ReusableAlertView.self)",
                               bundle: nil)
                        .instantiate(withOwner: nil,
                                     options: nil)[0] as? ReusableAlertView else {
            assertionFailure("Failed to instantiate ReusableAlertView from nib.")
            return ReusableAlertView()
        }
        view.configureUI()
        return view
    }
    
    /// 任一 Button 沒有 title，表示沒有 Button。
    func setupTitleLabel(title: String? = nil,
                         subtitle: String? = nil,
                         lhsText: AlertButtonTitle? = nil,
                         rhsText: AlertButtonTitle? = nil) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        
        if lhsText != nil {
            self.leftButton.setTitle(lhsText?.rawValue, for: .normal)
        } else {
            leftButton.removeFromSuperview()
        }
        
        if rhsText != nil {
            self.rightButton.setTitle(rhsText?.rawValue, for: .normal)
        } else {
            rightButton.removeFromSuperview()
        }
        
        if lhsText == nil || rhsText == nil {
            dividerView.removeFromSuperview()
        }
    }
    
    private func configureUI() {
        // 同 IBDesignable
        self.bottomView.layer.cornerRadius = 7
        self.bottomView.layer.borderWidth = 3
//        self.bottomView.layer.borderColor = titleColor.cgColor
        self.bottomView.layer.borderColor = UIColor.systemOrange.cgColor

        
        self.titleLabel.textColor = titleColor
        self.subtitleLabel.textColor = titleColor
        self.leftButton.backgroundColor = themeColor
        self.leftButton.setTitleColor(.white, for: .normal)
        self.leftButton.layer.cornerRadius = 5
        self.rightButton.backgroundColor = themeColor
        self.rightButton.setTitleColor(.white, for: .normal)
        self.rightButton.layer.cornerRadius = 5
    }
    
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        defer { removeFromSuperview() }
        delegate?.buttonAction()
        delegate?.leftButtonAction()
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        defer { removeFromSuperview() }
        delegate?.buttonAction()
        delegate?.rightButtonAction()
    }
}
