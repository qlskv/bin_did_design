//
//  IntroViewController.swift
//  ezDIDHolder_Design
//
//  Created by 이순빈 on 2021/09/06.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initView()
    }
    
    func initView() {
            guard let _ = self.navigationController?.viewControllers.first(where: { $0 is MainTabBarController }) else {
                let vc = self.storyboard?.instantiateViewController(
                    withIdentifier: "MainTabBarController")
                self.navigationController?.pushViewController(vc!, animated: true)
                return
            }
    }
}
