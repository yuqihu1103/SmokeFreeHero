//
//  ThreadsTableViewCell.swift
//  SmokeFreeLife
//
//  Created by Zoey H on 12/5/23.
//

import UIKit

class ThreadsTableViewCell: UITableViewCell {
    
    var wrapperCellView:UITableViewCell!
    var labelDt: UILabel!
    var labelContent: UILabel!
    var labelPoster: UILabel!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelDt()
        setuplabelPoster()
        setuplabelContent()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelDt(){
         labelDt = UILabel()
         labelDt.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .light)
         labelDt.translatesAutoresizingMaskIntoConstraints = false
         wrapperCellView.addSubview(labelDt)
    }
    
    func setuplabelPoster(){
        labelPoster = UILabel()
        labelPoster.font = UIFont.boldSystemFont(ofSize: 16)
        labelPoster.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPoster)
    }
    
    func setuplabelContent(){
         labelContent = UILabel()
        labelContent.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
         labelContent.translatesAutoresizingMaskIntoConstraints = false
         wrapperCellView.addSubview(labelContent)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
                    
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            labelPoster.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelPoster.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelPoster.heightAnchor.constraint(equalToConstant: 18),
            labelPoster.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor, constant: -20),
            
            labelDt.topAnchor.constraint(equalTo: labelPoster.bottomAnchor, constant: 5),
            labelDt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelDt.heightAnchor.constraint(equalToConstant: 18),
            labelDt.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor, constant: -20),
            
            labelContent.topAnchor.constraint(equalTo: labelDt.bottomAnchor, constant: 5),
            labelContent.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelContent.heightAnchor.constraint(equalToConstant: 18),
            labelContent.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor, constant: -20),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
