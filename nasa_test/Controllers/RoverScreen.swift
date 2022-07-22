//
//  RoverScreen.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit

class RoverViewController: UIViewController{
    
    private lazy var testCV: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 150, height: 150)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(RoverCell.self, forCellWithReuseIdentifier: RoverCell.identifier)
        
        return collectionView
    }()

    
    var curiosity: RoverPhoto?
//    var opportunity: RoverPhoto?
//    var spirit: RoverPhoto?
    
    
    
    private func fetchCuriosity() {
      APICaller.shared.getDataCuriosity{ [weak self] result in
        DispatchQueue.main.async { [self] in
          switch result {
          case .success(let model):

            self?.curiosity = model
            print(self?.curiosity?.photos.count)
              self?.testCV.reloadData()
          case .failure(let error):
            print("Parsing Error: \(error.localizedDescription)")
  //          self?.failedToGetProfile()
          }
        }
      }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubviews(testCV)
        
        testCV.snp.makeConstraints{
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
        
        
        
        testCV.dataSource = self
        testCV.delegate = self
        view.backgroundColor = .red
        fetchCuriosity()
    }


}

extension RoverViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let curiosity = curiosity?.photos.prefix(100).count{
            return curiosity
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverCell.identifier, for: indexPath) as? RoverCell else {
            return UICollectionViewCell()
        }
        
        if let curiosity = curiosity?.photos[indexPath.row]{
            cell.setup(with: RoverViewModel(roverId: curiosity.id, roverImg: curiosity.imgSrc, roverDate: curiosity.earthDate))
        }

        
        
    return cell
    }
    
    
}

