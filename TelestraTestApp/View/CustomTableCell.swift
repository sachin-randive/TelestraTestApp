//
//  CustomTableCell.swift
//  TelestraTestApp
//
//  Created by Sachin Randive on 19/04/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    
    //MARK: - Outlets
    
    private let lblName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.titleColor
        lbl.font = UIFont(name: "Helvetica-bold", size: 18)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let lblDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Helvetica", size: 15)
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let imgNamae : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = false
        return imgView
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.themeColor
        addSubview(lblName)
        addSubview(lblDescription)
        addSubview(imgNamae)
        
        imgNamae.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        lblName.anchor(top: topAnchor, left: imgNamae.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: frame.size.width, height: 0, enableInsets: false)
        lblDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        lblDescription.anchor(top: lblName.bottomAnchor, left: imgNamae.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: frame.size.width, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setCellInformation methods
    
    func setCellInformation(row: Row) {
        imgNamae.imageFromServerURL(row.imageHref ?? "", placeHolder: #imageLiteral(resourceName: "placeholder"))
        lblName.text = row.title
        lblDescription.text = row.rowDescription
    }
}

