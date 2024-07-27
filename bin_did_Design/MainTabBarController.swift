//
//  MenuTabController.swift
//  ezDIDHolder
//
//  Created by mac on 2021/07/27.
//

import UIKit

let kBarHeight: CGFloat = 80.0;
//2021-07-27, bin, 메뉴 스토리보드 탭바 컨트롤러 추가
class MainTabBarController: UITabBarController {
    var index: Int? = 0
    //2021-09-06, bin, MainTabBar Navigation겹침 버그 개선
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.reloadInputViews()
        
            let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil    )
            backButton.setBackgroundImage(UIImage(named: "arrow"), for: .normal, barMetrics: .default)
            navigationItem.setLeftBarButton(backButton, animated: false)

            // Do any additional setup after loading the view.
        
    }
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        //2021-07-29, bin, 앱 로드 시 메인 탭 중 1번째 탭으로 이동하게 설정.
        self.selectedIndex = index!
        self.tabBar.backgroundColor = UIColor.clear
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        //self.tabBarItem.imageInsets = UIEdgeInsets(top: 50, left: 0, bottom: -6, right: 0)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabBarController = segue.destination as? UITabBarController
        tabBarController?.selectedIndex = index!
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.frame.size.height = kBarHeight
        tabBar.frame.origin.y = view.frame.height - kBarHeight
    }
    
}

