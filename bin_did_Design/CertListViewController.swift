//
//  CertListViewController.swift
//  ezDIDHolder
//
//  Created by 이순빈 on 2021/07/28.
//
import UIKit

class CertListViewController: UIViewController {
    // var isSearching = false
    var selectedText: [String]! // filterdata
    let certList: [String] = ["코로나19예방접종 증명서", "코로나19예방접종 증명서", "분당서울대학교 병원진료증", "코로나19예방접종 증명서", "코로나19예방접종 증명서", "코로나19예방접종 증명서", "코로나19예방접종 증명서", "분당서울대학교 병원진료증", "분당서울대학교 병원진료증", "한글"] // data
    
    @IBOutlet var searchbar: UISearchBar!
    // 2021-08-03, 이순빈, CertList화면 CollectionView적용
    @IBOutlet var enableCertCount: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //navigationController?.setNavigationBarHidden(true, animated: true)
        enableCertCount.text = String(selectedText.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchbar.delegate = self
        selectedText = certList
        // 2021-08-06, 이순빈, search bar 기능 추가
        let searchController = UISearchController(searchResultsController: nil)
    }
}

// cell data
extension CertListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedText.count
        // return certList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CertListCollectionViewCell
        if selectedText.count != 0 {
            cell.backgroundColor = .white
            cell.lbl.text = selectedText[indexPath.row]
            cell.certBtn.tag = indexPath.row
            cell.certBtn.addTarget(self, action: #selector(viewdetail), for: .touchUpInside)
        } else {
            cell.backgroundColor = .white
            cell.lbl.text = certList[indexPath.row]
            cell.certBtn.tag = indexPath.row
            cell.certBtn.addTarget(self, action: #selector(viewdetail), for: .touchUpInside)
        }
        return cell
        // let list = isSearching ? selectedText[indexPath.row] : certList[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    // 2021-08-06, 이순빈, webkit test 중
    @objc func viewdetail(sender: UIButton) {
        var description: String!
        print(sender.tag)
        print(IndexPath())
        CERT:
        if (UserDefaults.standard.string(forKey: "USER_PIN_PASSWORD")) == nil {
            TEST:
            if sender.tag == 2 {
                print("now")
                
                break CERT
            }
            
            let indexpath1 = IndexPath(row: sender.tag, section: 0)
            let home = storyboard?.instantiateViewController(withIdentifier: "CollectionCelltoViewController") as! CollectionCelltoViewController
            home.certList = certList[indexpath1.row]
            navigationController?.pushViewController(home, animated: true)
        }
    }
}

extension CertListViewController: UICollectionViewDelegateFlowLayout {
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // 2021-09-01, 이순빈, CertList화면 개선 중
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let width = collectionView.frame.width / 2 - 1
            let height = collectionView.frame.height
            
            let itemsPerRow: CGFloat = 2
            let itemsPerColumn: CGFloat = 4
            let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
            let cellHeight = (height - heightPadding) / itemsPerColumn
            return CGSize(width: width, height: cellHeight)
        }
    }

// 2021-08-06, 이순빈, search bar 기능 추가
extension CertListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        enableCertCount.text = String(selectedText.count)
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Le clavier se ferme :
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // filterdata  = searchText.isEmpty ? data : data.filter {(item : String) -> Bool in
        selectedText = searchText.isEmpty ? certList : certList.filter { $0.lowercased().contains(searchText.lowercased()) }
        // return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        enableCertCount.text = String(selectedText.count)
        collectionView.reloadData()
    }
}
extension UILabel {

    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}
