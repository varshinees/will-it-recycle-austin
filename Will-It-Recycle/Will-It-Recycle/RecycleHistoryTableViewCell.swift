//
//  RecycleHistoryTableViewCell.swift
//  Will-It-Recycle
//
//  Created by Victoria Denney on 3/30/21.
//

import UIKit

class RecycleHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recycledItemCount: UILabel!
    @IBOutlet weak var recycleDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
