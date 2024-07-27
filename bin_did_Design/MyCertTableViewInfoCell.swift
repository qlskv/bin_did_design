//
//  MyCertTableViewInfoCell.swift
//  ezDIDHolder_Design
//
//  Created by bin on 2021/09/06.
//

import UIKit

class MyCertTableViewInfoCell: UITableViewCell {
    @IBOutlet weak var assertionNameLabel: UILabel!
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var patientNumberLabel: UILabel!
    
    @IBOutlet weak var patientNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
      if highlighted {
        background.backgroundColor = UIColor.lightGray
      } else {
        background.backgroundColor = UIColor.clear
      }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
      if selected {
        background.backgroundColor = UIColor.lightGray
      } else {
        background.backgroundColor = UIColor.clear
      }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
    }

}
