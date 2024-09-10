//
//  Enums.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/12/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

enum MessageType {
    case incoming
    case outgoing
}

enum AprSdkMessageKindChoise {
    case text
    case photo
    case video
    case location
    case voice
}

enum AprSdkRequestType {
    case sent
    case recived
}

