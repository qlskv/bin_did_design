//
//  MyCertViewController.swift
//  ezDIDHolder_Design
//
//  Created by 이순빈 on 2021/09/06.
//

import UIKit

class MyCertViewController: UIViewController {
    var array = [String]()
    //var tableArray = [String]()
    //var descriptions = ["First"]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var tableArray = UserDefaults.standard.object(forKey: "TABLE") as? [String] ?? []
    
    @IBOutlet var myCertView: UIView!
    @IBOutlet weak var emptySubView: UIView!
    @IBOutlet weak var editCertBtn: UIButton!
    @IBOutlet weak var certLbl: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var emptyBtn: UIButton!
    @IBOutlet weak var certCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        certLbl.textAlignment = .left
        myTable.rowHeight = UITableView.automaticDimension
        emptyBtn.addTarget(self, action: #selector(handleTouchUpInside(_:)), for: .touchUpInside)
        editCertBtn.addTarget(self, action: #selector(handleTouchUpInside(_:)), for: .touchUpInside)
        self.view.addSubview(self.emptySubView)
        // Do any additional setup after loading the view.
        tableArray = appDelegate.myCertList
    }
    
    func loadData() {
        certCount.text = String(tableArray.count)
        myTable.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        //2021-09-01, 이순빈, claim없을 시 empty view 로드
        
        self.view.sendSubviewToBack(self.emptySubView)
        if tableArray.count == 0 {
            self.view.bringSubviewToFront(self.emptySubView)
        }
        // navigationController?.setNavigationBarHidden(true, animated: true)
        certCount.text = String(tableArray.count)
        loadData()
    }
    @objc func handleTouchUpInside(_ sender: Any) {
        if emptyBtn.isEqual(sender) {
            /*
             let vc = storyboard?.instantiateViewController(withIdentifier: "CertListViewController") as! CertListViewController
             //vc.index = 1
             navigationController?.pushViewController(vc, animated: true)
             */
            dump(tableArray)
            tabBarController?.selectedIndex = 1
            //self.tabBarMove()
        }
        else if editCertBtn.isEqual(sender) {
            if self.myTable.isEditing {
                //self.editCertBtn.
                self.editCertBtn.setTitle("증명서 편집", for: .normal)
                self.editCertBtn.setTitleColor(UIColor.white, for: .normal)
                self.editCertBtn.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2117647059, blue: 0.2588235294, alpha: 1)
                self.myTable.setEditing(false, animated: true)
            } else {
                self.editCertBtn.setTitle("편집 완료", for: .normal)
                self.editCertBtn.setTitleColor(UIColor.darkGray, for: .normal)
                self.editCertBtn.backgroundColor = #colorLiteral(red: 0.9625374675, green: 0.9625598788, blue: 0.9625478387, alpha: 0.8980392157)
                self.myTable.setEditing(true, animated: true)
            }
        }
    }
    @IBAction func editTable(_ sender: Any) {
        
    }
    
    func tabBarMove() {
        let vc = storyboard?.instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController
        vc.index = 1
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension MyCertViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableArray.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            print("delete")
            self.loadData()
            
            appDelegate.myCertList.remove(at: indexPath.row)
            self.tableArray.remove(at: indexPath.row)
                
            
            //self.tableArray.remove(at: indexPath.row)
            //self.itemName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        self.loadData()
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == (tableArray.count ?? 0) {
            return .none
            
        }
        else {
            return .delete
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (tableArray.count ?? 0) {
            
            let cell = myTable.dequeueReusableCell(withIdentifier: "MyCertTableViewAddCell", for: indexPath) as! MyCertTableViewAddCell
            //cell.selectionStyle = .none
            cell.moveButton.addTarget(self, action: #selector(issueCert), for: .touchUpInside)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .black
            cell.textLabel?.numberOfLines = 2
            
            return cell
        } else {
            let cell = myTable.dequeueReusableCell(
                withIdentifier: "MyCertTableViewInfoCell", for: indexPath) as! MyCertTableViewInfoCell
            
            cell.selectionStyle = .none
            //cell.assertionNameLabel.text = "진료증"
            //cell.patientNumberLabel.text = "이순빈"
            //cell.patientNumberLabel.text = "0907"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .black
            cell.textLabel?.numberOfLines = 2
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 227
    }
    @objc func issueCert(sender: UIButton) {
        tabBarController?.selectedIndex = 1
        dump(tableArray)
    }
    @IBAction func unwindMain (_ sender: UIStoryboardSegue){
        print("i'm back")
    }
}

