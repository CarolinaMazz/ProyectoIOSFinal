//
//  itemCompra.swift
//  ProyectoIOSFinal
//
//  Created by Carolina Mazzaglia on 28/04/17.
//  Copyright © 2017 Carolina Mazzaglia. All rights reserved.
//

import UIKit

class itemCompra: UITableViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lbNombre: UILabel!

    @IBOutlet weak var lbPrecio: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
