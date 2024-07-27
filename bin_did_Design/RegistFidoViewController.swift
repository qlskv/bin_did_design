//
//  RegistFidoViewController.swift
//  ezDIDHolder
//
//  Created by mac on 2021/07/29.
//

import UIKit
// 2021-08-21, bin 생체인증 UI개선사항 적용 중
class RegistFidoViewController: UIViewController {
    // MARK: - Properties

    // MARK: - Outlets

    @IBOutlet var lbl: UILabel!
    @IBOutlet var lblUnder: UILabel!
    @IBOutlet var nowRegitBtn: UIButton!
    @IBOutlet var laterRegitBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 2021-08-26, 이순빈, 생체등록페이지 글자 굵게 강조 적용
        let notosanKr = UIFont(name: "NotoSansCJKkr-Regular", size: 26)

        let attributedStr = NSMutableAttributedString(string: self.lbl.text!)
        let attributedStr2 = NSMutableAttributedString(string: self.lblUnder.text!)

        //attributedStr.addAttribute(.font, value: notosanKr!, range: (self.lbl.text! as NSString).range(of: "을 위해"))
        self.lbl.attributedText = attributedStr

        //attributedStr2.addAttribute(.font, value: notosanKr!, range: (self.lblUnder.text! as NSString).range(of: "을 등록해 주세요."))
        self.lblUnder.attributedText = attributedStr2

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        self.nowRegitBtn.addTarget(self, action: #selector(self.handleTouchUpInside(_:)), for: .touchUpInside)
        self.laterRegitBtn.addTarget(self, action: #selector(self.handleTouchUpInside(_:)), for: .touchUpInside)
    }

    @objc func handleTouchUpInside(_ sender: Any) {
        
    }

    


    private func goCompleteView() {
        let vc = self.storyboard?.instantiateViewController(
            withIdentifier: "RegistCompleteViewController") as! RegistCompleteViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NSMutableAttributedString {
    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }

    func normal(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
}
