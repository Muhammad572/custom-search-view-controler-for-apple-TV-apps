//
//  ChannelsModel.swift
//  StandUpComedyApp
//
//  Created by ZeeshanFayyaz on 08/10/2018.
//  Copyright © 2018 ZeeshanFayyaz. All rights reserved.
//

import Foundation
import UIKit
import XCDYouTubeKit

var chanalname = ""
var favouriteArray = [ChannelVedios]()

class channels : NSObject{
    var ChannelId: String
    var Descrp: String
    var Thumnails: String
    var ChannelTitle: String
    var PageToken: String
    
    override init() {
        self.ChannelId = ""
        self.Descrp = ""
        self.Thumnails = ""
        self.ChannelTitle = ""
        self.PageToken = ""
    }
    
    init(channelId: String, descrp: String, thum: String, channelTitle: String, pageToken: String) {
        
        self.ChannelId = channelId
        self.Descrp = descrp
        self.Thumnails = thum
        self.ChannelTitle = channelTitle
        self.PageToken = pageToken
    }
    
}


struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}
