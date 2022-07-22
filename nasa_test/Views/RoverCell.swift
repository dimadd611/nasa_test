//
//  RoverCell.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

final class RoverCell: UICollectionViewCell {
    
    static let identifier = "RoverCell"
    
    
    //MARK: -UIElements
    private lazy var testImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
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
        backgroundColor = .blue
        
        addSubviews(testImage, dateLabel, idLabel)
        
        dateLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints{
            $0.bottom.equalTo(dateLabel.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        testImage.snp.makeConstraints{
            $0.bottom.equalTo(idLabel.snp.top)
            $0.leading.trailing.top.equalToSuperview()
        }
        
    }
    
    public func setup(with model: RoverViewModel){
        
        guard let urlString = URL(string: "\(model.roverImg)") else {return}
        testImage.sd_setImage(with: urlString, completed: nil)
        idLabel.text = "ID: \(model.roverId)"
        dateLabel.text = "DATE: \(model.roverDate)"
    }
    
}



















