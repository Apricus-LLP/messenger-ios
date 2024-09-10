//
//  Network.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 6/27/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation
import Reachability

class Network {
    
    static let shared = Network()
    
    public var isReachable = false { didSet { updateConnectionStatus?(isReachable) } }
    private var reachability      : Reachability?
    
    var updateConnectionStatus: ((Bool)->())?
    
    init() {
        checkConnection()
    }
    
    public func checkConnection() {
        stopNotifier()
        setupReachability()
        startNotifier()
    }
    
    private func setupReachability() {
        let reachable: Reachability?
        do {
            reachable = try Reachability()
            reachability = reachable
            reachability?.whenReachable = { reachability in
                self.updateLabelColourWhenReachable(reachability)
            }
            reachability?.whenUnreachable = { reachability in
                self.updateLabelColourWhenNotReachable(reachability)
            }
        } catch {
            //
        }
        
    }
    
    private func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            print( "Unable to start\nnotifier")
            return
        }
    }
    
    private func stopNotifier() {
        reachability?.stopNotifier()
    }
    
    private func updateLabelColourWhenReachable(_ reachability: Reachability) {
        isReachable = true
    }
    
    private func updateLabelColourWhenNotReachable(_ reachability: Reachability) {
        isReachable = false
    }
}

