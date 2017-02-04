//
//  ClearCell.swift
//  FaceDex
//
//  Created by Benjamin Emdon on 2017-02-04.
//  Copyright © 2017 Benjamin Emdon. All rights reserved.
//

import UIKit

class ClearCell: UITableViewCell {

	var title: String?
	private let titleLabel = UILabel()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)

		contentView.backgroundColor = UIColor.clear
		backgroundColor = UIColor.clear

		let blurEffect = UIBlurEffect(style: .light)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.layer.cornerRadius = 10
		blurEffectView.layer.masksToBounds = true
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(blurEffectView)

		titleLabel.textAlignment = .left
		titleLabel.frame = bounds
		titleLabel.textColor = UIColor.darkText
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(titleLabel)

		NSLayoutConstraint.activate([
			blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),


			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			])
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func render() {
		if let text = title {
			titleLabel.text = text
		}
	}

	override func prepareForReuse() {
		titleLabel.text = nil
		title = nil
	}
}

