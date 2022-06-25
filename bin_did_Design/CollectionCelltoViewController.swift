//
//  CollectionCelltoViewController.swift
//  ezDIDHolder_Design
//
//  Created by 이순빈 on 2021/09/06.
//

import UIKit

@available(iOS 13.0, *)
class CollectionCelltoViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var detailLbl: UILabel!
    
    @IBOutlet weak var issuedBtn: UIButton!
    var dataOutRow: String?
    var certList:String!=nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        detailLbl.text = certList
        
        if dataOutRow != nil {
            textField.text = dataOutRow
            
            // Do any additional setup after loading the view.
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! MyCertViewController
                dest.tableArray.append(textField.text!)
                //dest.myTable?.reloadData()
                UserDefaults.standard.set(true, forKey: "CERT")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.myCertList.append(textField.text!)
                UserDefaults.standard.set(appDelegate.myCertList, forKey: "TABLE")
    }
}
