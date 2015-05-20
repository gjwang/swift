//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by gjwang on 5/17/15.
//  Copyright (c) 2015 gjwang. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    var tweet: Tweet?{
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
   
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func updateUI(){
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text  != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetTextLabel?.text = "\(tweet.user)"
            
            if let profileImage = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImage) {
                    //block main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
        }
    }
}
