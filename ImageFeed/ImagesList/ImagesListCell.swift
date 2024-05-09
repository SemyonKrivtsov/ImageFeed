//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Семён Кривцов on 04.05.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    // MARK: - Static property
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - IBOutlets
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Private property
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Internal property
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath)  {
        
        guard let image = UIImage(named: String(indexPath.row)) else {
            return
        }
        
        cell.cellImageView.image = image
        
        cell.dateLabel.text = dateFormatter.string(from: Date())
        
        let likeImageName = indexPath.row % 2 == 0 ? "like_button_on" : "like_button_off"
        guard let likeImage = UIImage(named: likeImageName) else { return }
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}
