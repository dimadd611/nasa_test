//
//  RoverTypeCell.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit
import SnapKit
final class RoverTypeCell: UICollectionViewCell {
    
    static let identifier = "RoverTypeCell"
    //MARK: -UIElements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    
    //MARK: -Variables
    
    
    //MARK: -Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions
    private func setupLayout() {
        backgroundColor = .black
        layer.cornerRadius = 15
        layer.masksToBounds = true
        addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    func setup(title: String){
        titleLabel.text = title
    }
}



















