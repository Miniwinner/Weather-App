//
//  tableViewCell.swift
//  CallReminder
//
//  Created by Александр Кузьминов on 30.07.23.
//

import UIKit

class tableViewCell: UITableViewCell {

//    var weather = WheatherData()
    
    
    @IBOutlet weak var tableWeather: UILabel!
    
    @IBOutlet weak var tableTempearture: UILabel!
    
    @IBOutlet weak var tableImage: UIImageView!
    let weatherDay = "Сегодня"
    let temp = "13°"
    let image = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        tableWeather.text = weatherDay
        
        
        tableTempearture.text = temp
        tableTempearture.textColor = .white
        
        tableImage.image = UIImage(named: image)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
