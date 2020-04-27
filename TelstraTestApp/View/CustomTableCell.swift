//
//  CustomTableCell.swift
//  TelstraTestApp
//
//  Created by Sachin Randive on 19/04/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    
    //MARK: - Outlets
    
    private let lblName : UILabel = {
        
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: TTAppConfig.customFontBold, size: CGFloat(TTAppConfig.titleFontSize))
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let lblDescription : UILabel = {
        
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: TTAppConfig.customFont, size: CGFloat(TTAppConfig.descFontSize))
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let imgProfileName : UIImageView = {
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
        addSubview(imgProfileName)
        
        imgProfileName.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, enableInsets: false)
        imgProfileName.anchorSize(width: CGFloat(TTAppConfig.imageViewWidth), height: CGFloat(TTAppConfig.imageViewHeight))
        
        lblName.anchor(top: topAnchor, left: imgProfileName.rightAnchor, bottom: nil, right: rightAnchor, enableInsets: false)
        imgProfileName.anchorSize(width: frame.size.width, height: CGFloat(TTAppConfig.zero))
        
        lblDescription.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(TTAppConfig.heightConstant)).isActive = true
        lblDescription.anchor(top: lblName.bottomAnchor, left: imgProfileName.rightAnchor, bottom: bottomAnchor, right: rightAnchor, enableInsets: false)
        lblDescription.anchorSize(width: frame.size.width, height: CGFloat(TTAppConfig.zero))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setCellInformation methods
    
    func setCellInformation(row: Row) {
        
        imgProfileName.imageFromServerURL(row.imageHref ?? "", placeHolder: #imageLiteral(resourceName: "placeholder"))
        lblName.text = row.title
        lblDescription.text = row.rowDescription
    }
}

