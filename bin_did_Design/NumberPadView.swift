//
//  NumberPadView.swift
//  ezDIDHolder
//
//  Created by bin on 2021/07/10.
//

import UIKit

class NumberPadView: UIView {

    // MARK: - Properties
    
    weak var delegate: NumberPadViewProtocol?
    var value: String = "" {
        willSet(newValue) {
            let oldMaxLength = maxLength ?? value.count
            let newMaxLength = maxLength ?? newValue.count
            if (oldMaxLength != newMaxLength) {
                // remove all subviews
                secretStackView.subviews.forEach({ $0.removeFromSuperview() })
                for _ in 0..<newMaxLength {
                    let imageView = UIImageView(
                        image: UIImage(named: "circle-empty"),
                        highlightedImage: UIImage(named: "circle-fill"))
                    secretStackView.addSubview(imageView)
                }
            }
            for idx in 0..<newMaxLength {
                if let imageView = secretStackView.arrangedSubviews[idx] as? UIImageView {
                    imageView.isHighlighted = idx < newValue.count
                }
            }
        }
    }
    var maxLength: Int?
    var font: UIFont = UIFont.systemFont(ofSize: 15) {
        willSet(newValue) {
            btn1.titleLabel?.font = newValue
            btn2.titleLabel?.font = newValue
            btn3.titleLabel?.font = newValue
            btn4.titleLabel?.font = newValue
            btn5.titleLabel?.font = newValue
            btn6.titleLabel?.font = newValue
            btn7.titleLabel?.font = newValue
            btn8.titleLabel?.font = newValue
            btn9.titleLabel?.font = newValue
            btn0.titleLabel?.font = newValue
            btnClear.titleLabel?.font = newValue
            btnDelete.titleLabel?.font = newValue
        }
    }
    var textColor: UIColor? {
        willSet(newValue) {
            btn1.setTitleColor(newValue, for: btn1.state)
            btn2.setTitleColor(newValue, for: btn2.state)
            btn3.setTitleColor(newValue, for: btn3.state)
            btn4.setTitleColor(newValue, for: btn4.state)
            btn5.setTitleColor(newValue, for: btn5.state)
            btn6.setTitleColor(newValue, for: btn6.state)
            btn7.setTitleColor(newValue, for: btn7.state)
            btn8.setTitleColor(newValue, for: btn8.state)
            btn9.setTitleColor(newValue, for: btn9.state)
            btn0.setTitleColor(newValue, for: btn0.state)
            btnClear.setTitleColor(newValue, for: btnClear.state)
            btnDelete.setTitleColor(newValue, for: btnDelete.state)
        }
    }

    // MARK: - Outlets

    @IBOutlet weak var secretStackView: UIStackView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView(UIFont.systemFont(ofSize: 15))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView(UIFont.systemFont(ofSize: 15))
    }
    
    private func loadView(_ font: UIFont) {
        if let view = Bundle.main.loadNibNamed("NumberPadView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
            
            setButtonColor(btn1, self.tintColor, for: .normal)
            setButtonColor(btn2, self.tintColor, for: .normal)
            setButtonColor(btn3, self.tintColor, for: .normal)
            setButtonColor(btn4, self.tintColor, for: .normal)
            setButtonColor(btn5, self.tintColor, for: .normal)
            setButtonColor(btn6, self.tintColor, for: .normal)
            setButtonColor(btn7, self.tintColor, for: .normal)
            setButtonColor(btn8, self.tintColor, for: .normal)
            setButtonColor(btn9, self.tintColor, for: .normal)
            setButtonColor(btn0, self.tintColor, for: .normal)
            setButtonColor(btnClear, self.tintColor, for: .normal)
            setButtonColor(btnDelete, self.tintColor, for: .normal)

            btn1.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn2.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn3.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn4.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn5.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn6.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn7.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn8.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn9.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btn0.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btnClear.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
            btnDelete.addTarget(self, action: #selector(handlTouchUpInside), for: .touchUpInside)
        }
    }
    
    func setButtonColor(_ button: UIButton, _ color: UIColor?, for state: UIControl.State) {
        button.setTitleColor(self.tintColor, for: state)
        button.tintColor = self.tintColor
        button.backgroundColor = self.backgroundColor
    }
    
    // MARK: - Event handlers

    @objc func handlTouchUpInside(sender: UIButton) {
        switch sender.tag {
        case -100:  // clear
            self.value = ""
            break
        case -1:    // delete
            if (value.count > 0) {
                let startIdx = self.value.startIndex
                let endIdx = self.value.index(before: self.value.endIndex)
                self.value = String(self.value[startIdx..<endIdx])
            }
            break
        default:    // numbers
            if self.maxLength == nil || self.value.count < self.maxLength! {
                self.value = String(format: "%@%@", self.value, String(sender.tag))
            }
            break
        }
        
        delegate?.valueUpdated(sender: self, value: self.value)
    }
}

protocol NumberPadViewProtocol: AnyObject {
    func valueUpdated(sender: Any, value: String);
}
