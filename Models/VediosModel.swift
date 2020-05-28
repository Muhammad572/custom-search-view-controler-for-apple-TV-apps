//
//  VediosModel.swift
//  StandUpComedyApp
//
//  Created by ZeeshanFayyaz on 08/10/2018.
//  Copyright © 2018 ZeeshanFayyaz. All rights reserved.
//

import Foundation
import UIKit

class ChannelVedios: NSObject,NSCoding {
    
    
    var VedioId: String
    var ChannelId: String
    var VedioTitle: String
    var Thumnails: String
    var TokenNum: String
    
    override init() {
        self.VedioId = ""
        self.ChannelId = ""
        self.VedioTitle = ""
        self.Thumnails = ""
        self.TokenNum = ""
    }
    
    init(vedioId: String,channelId: String,vedioTitle: String,thumnail: String,tokenNum: String) {
        self.VedioTitle = vedioTitle
        self.ChannelId = channelId
        self.VedioId = vedioId
        self.Thumnails = thumnail
        self.TokenNum = tokenNum
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(VedioId, forKey: "VedioId")
        aCoder.encode(ChannelId, forKey: "ChannelId")
        aCoder.encode(VedioTitle, forKey: "VedioTitle")
        aCoder.encode(Thumnails, forKey: "Thumnails")
        aCoder.encode(TokenNum, forKey: "TokenNum")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let VedioId = aDecoder.decodeObject(forKey: "VedioId") as! String
        let ChannelId = aDecoder.decodeObject(forKey: "ChannelId") as! String
        let VedioTitle = aDecoder.decodeObject(forKey: "VedioTitle") as! String
        let Thumnails = aDecoder.decodeObject(forKey: "Thumnails") as! String
        let TokenNum = aDecoder.decodeObject(forKey: "TokenNum") as! String
        self.init(vedioId: VedioId, channelId: ChannelId, vedioTitle: VedioTitle, thumnail: Thumnails, tokenNum: TokenNum)
    }
    //    init(objVedios: ChannelVedios) {
    //                self.VedioTitle = objVedios.VedioTitle
    //                self.ChannelId = objVedios.ChannelId
    //                self.VedioId = objVedios.VedioId
    //                self.Thumnails = objVedios.Thumnails
    //                self.tokenNum = objVedios.tokenNum
    //    }
}
