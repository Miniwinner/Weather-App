//
//  CollectionViewCell.swift
//  CallReminder
//
//  Created by Александр Кузьминов on 30.07.23.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var labelHour: UILabel!
    
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!
    func config(model:WeatherSource){
        labelHour.text = model.labelTextHour
        labelHour.textColor = .white
        
        
        iconView.image = UIImage(named: model.imageName)
        
        
        
        tempLabel.text = model.labelTextTemp
        tempLabel.textColor = .white
        tempLabel.layer.style 
    }
    
}


/*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if indexPath.section == 0 {
           // Настроить ячейку с UILabel
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierHour, for: indexPath) as! CollectionViewCell
           cell.hourLabel.text = hours[indexPath.row]
           cell.hourLabel.textColor = .green
           return cell
       } else if indexPath.section == 1 {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierImage, for: indexPath) as! IconCollectionViewCell
           cell.imageIconCell.backgroundColor = .white
           return cell
       } else {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierTemp, for: indexPath) as! TemperatureCollectionViewCell
           cell.tempLabel.text = hours2[indexPath.row]
           cell.tempLabel.textColor = .red
           return cell
       }
   }
*/
