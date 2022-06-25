//
//  CertificatePinViewController.swift
//  ezDIDHolder_Design
//
//  Created by 이순빈 on 2021/09/06.
//

import UIKit

class CertificatePinViewController: UIViewController, NumberPadViewProtocol {
    func valueUpdated(sender: Any, value: String) {
        if value.count == numPadView.maxLength {
            let password = UserDefaults.standard.string(forKey: "USER_PIN_PASSWORD")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistFidoViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    

    
    @IBAction func act2(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistFidoViewController") as! RegistFidoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet var numPadView: NumberPadView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numPadView.delegate = self
        numPadView.maxLength = 6
        numPadView.font = UIFont.systemFont(ofSize: 20)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
