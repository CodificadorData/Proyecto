import UIKit

class CellTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lblDia: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblTrabajador: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
