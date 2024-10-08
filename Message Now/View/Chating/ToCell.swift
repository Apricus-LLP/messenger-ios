//
//  ToCell.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 4/26/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class ToCell: UITableViewCell {

    var msgVM = MessageViewModel() { didSet {
        messageLabel.text = msgVM.text
        timeLabel.text    = msgVM.timestamp?.getMessageTime()
    }}
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubble: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    private func initView() {
        contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        userImage.layer.cornerRadius = 12.5
        userImage.image = UIImage(data: UserDefaults.standard.data(forKey: "image")!)
        bubble.image = UIImage(named: "apr_chat_bubble_recived")!.resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
        bubble.tintColor = UIColor(named: "BubbleRecived")
    }
    
    
}
