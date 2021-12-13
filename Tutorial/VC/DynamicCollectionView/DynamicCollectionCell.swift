//
//  DynamicCollectionViewCell.swift
//  Tutorial
//
//  Created by Leah on 2021/12/07.
//
import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    static func fittingSize(availableWidth: CGFloat, model: Message) -> CGSize {
        let cell = CollectionViewCell()
        cell.configure(model: model)
        
        let targetSize = CGSize(width: availableWidth, height:  UIView.layoutFittingCompressedSize.height)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
      label.textAlignment = .center
      label.textColor = .black
      label.numberOfLines = 0
      
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.sizeToFit()
        titleLabel.sizeToFit()
    }
    
    private func setupView() {
        backgroundColor = .black.withAlphaComponent(0.1)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
        }
        textLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(10)
//           make.top.left.equalToSuperview()
//            make.width.equalTo(textLabel.frame.width)
//            make.height.equalTo(textLabel.frame.height)
//            make.width.greaterThanOrEqualTo(100)
            make.right.top.bottom.equalToSuperview()
        }
    }
    
    func configure(model: Message) {
        titleLabel.text = model.nick
        textLabel.text = model.text
        
    }

}
