//
//  AprSdkMessage.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 4/30/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

struct AprSdkMessage {
    var key : String?
    var to: String?
    var text: String?
    var timestamp: Double?
    var msgKind: String?
    var photoURL: String?
    var latitude: Double?
    var longitude: Double?
    var videoURL:  String?
    var voiceURL:  String?
    var voiceSec:  Double?
}

struct RecentMessage {
    var to: String?
    var text: String?
    var timestamp: Double?
    var unreadCount: Int?
    var user: User?
}
