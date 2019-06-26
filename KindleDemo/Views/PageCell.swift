//
//  PageCell.swift
//  KindlDemo
//
//  Created by Findl on 5/10/19.
//  Copyright © 2019 YD. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam non diam mollis, feugiat tortor ut, facilisis sapien. Donec arcu dolor, cursus in libero varius, feugiat interdum odio. Suspendisse egestas porttitor velit et pharetra. Pellentesque in risus sollicitudin eros euismod malesuada. Morbi nec augue quis tellus elementum vehicula. Donec sit amet blandit leo. Integer a velit aliquam, sodales lacus sit amet, condimentum dolor. Donec gravida dignissim lacus hendrerit posuere. Suspendisse egestas laoreet sapien. Vivamus ullamcorper ipsum dui, nec placerat purus interdum ut. Ut blandit neque ut justo pulvinar tempor. Vestibulum ultricies accumsan turpis sit amet suscipit. Mauris porta commodo bibendum. Vestibulum venenatis sem ut est tincidunt, sed pellentesque felis condimentum."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
