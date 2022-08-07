//
//  CustomTableViewCell.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 13.07.2022.
//

import UIKit

class OfficeTableViewCell: UITableViewCell {
    
    // Basic elements of the cell:
    let nameLabel       = UILabel()
    let adressLabel     = UILabel()
    let statusLabel     = UILabel()
    let locationLabel   = UILabel()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Helpfull values:
        let screenRect      = UIScreen.main.bounds
        let screenWidth     = screenRect.size.width
        
        // Configure elements:
        nameLabelSetUp()
        adressLabelSetUp()
        statusLabelSetUp()
        locationLabelSetUp()
        
        // Adding elements to main view:
        addSubview(nameLabel)
        addSubview(adressLabel)
        addSubview(statusLabel)
        addSubview(locationLabel)
        
        // Setting up stack views:
        let hStackView = UIStackView(arrangedSubviews: [statusLabel, locationLabel])
        hStackView.distribution = .fillProportionally
        hStackView.axis = .horizontal
        hStackView.spacing = 5
        
        let vStackView = UIStackView(arrangedSubviews: [nameLabel, adressLabel, hStackView])
        vStackView.distribution = .equalSpacing
        vStackView.axis = .vertical
        vStackView.spacing = 2
        addSubview(vStackView)
        vStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 0, width: screenWidth-60, height: 0, enableInsets: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nameLabelSetUp() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
    }
    func adressLabelSetUp() {
        adressLabel.translatesAutoresizingMaskIntoConstraints = false
        adressLabel.font = UIFont.systemFont(ofSize: 12)
        adressLabel.textAlignment = .left
        adressLabel.textColor = .systemGray
    }
    func statusLabelSetUp() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.textAlignment = .left
        statusLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    func locationLabelSetUp() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = UIFont.systemFont(ofSize: 12)
        locationLabel.textAlignment = .left
        locationLabel.textColor = .systemGray
    }
    
    func configure(with model: OfficeTableViewCellModel) {
        nameLabel.text      = model.name
        adressLabel.text    = model.shortAdress
        let timeCalc = LocalTimeCalculator.shared
        
        // Calculate Office status
        let day = LocalTimeCalculator.shared.getDayOfWeek()
        if model.graf.indices.contains(day-1) {
            let status = timeCalc.calcOfficeWorkTime(openHours: model.graf[day-1].SBEGIN!, closeHours: model.graf[day-1].SEND!)
            if status == "Открыт" {
                statusLabel.textColor = #colorLiteral(red: 0.1555454731, green: 0.5112220049, blue: 0.2336485088, alpha: 1)
            }
            if status == "Закрыт" {
                statusLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
            statusLabel.text = status
        } else {
            statusLabel.text = ""
        }
        
        
        let distance = LocationManger.shared.calculateDistance(latitude: model.latitude, longtitude: model.longtitude)
        
        locationLabel.text  = "до офиса \(Int(distance)) км."
    }
    
}


