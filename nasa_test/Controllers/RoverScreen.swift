//
//  RoverScreen.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation
import UIKit



final class RoverViewController: UIViewController{
    
    // MARK: - UIElements
    private lazy var testCV: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 150, height: 150)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(RoverCell.self, forCellWithReuseIdentifier: RoverCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Variables
    private var curiosity: [Rover]?
    private var isFetchingData = false
    private var currentPage = 1
    var screenType: ScreenType!
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    // MARK: - Functions
    convenience init(photos: [Rover], rootOption option: ScreenType){
        self.init()
        self.curiosity = photos
        screenType = option
        title = screenType.roverType
    }
    
    @objc func reload(){
        testCV.reloadData()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubviews(testCV)
        testCV.snp.makeConstraints{
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    

}

// MARK: - Extension CollectionView DataSource

extension RoverViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let curiosity = curiosity?.count {
              return curiosity
          }
        return 0
      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverCell.identifier, for: indexPath) as? RoverCell else {
            return UICollectionViewCell()
        }
        
        if let curiosity = curiosity?[indexPath.row]{
            cell.setup(with: RoverViewModel(roverId: Int(curiosity.id), roverImg: curiosity.image ?? "", roverDate: curiosity.earthDate ?? ""))
          }

        return cell
    }
}

// MARK: - Extension CollectionView Delegate

extension RoverViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) { _ in
            
          let delete = UIAction(title: "Delete Item",
                                image: UIImage(systemName: "trash.fill"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                                attributes: .destructive
          ) {_  in
              guard let massiv = self.curiosity?[indexPath.row] else {return}
              
              CoreDataManager.shared.deleteNote(massiv)
              self.testCV.reloadData()
//              self.deletephotos(point: indexPath.row)
//              self.deleteFolder(indexPath.row)
//                      if let data = try? PropertyListEncoder().encode(self.folders) {
//                             UserDefaults.standard.set(data, forKey: "Folders")
//                         }
          }
            
            
            let open = UIAction(title: "Share Item",
                                  image: UIImage(systemName: "arrow.forward.circle"),
                                  identifier: nil,
                                  discoverabilityTitle: nil
                                  
                                  
            ) {_ in
                guard let link = self.curiosity?[indexPath.row].image else {return}
                let url = URL(string: link)!
                let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                UIApplication.presentedViewController?.present(activityVC, animated: true, completion: {
//                    IHProgressHUD.dismiss()
                })
                
            }
            
            
          return UIMenu(title: "",
                        image: nil,
                        identifier: nil,
                        options: UIMenu.Options.displayInline,
                        children: [open, delete])
        }
        return config
    }
}
