//
//  AppLaunchAdapter.swift
//  HealthWealth
//
//  Created by Vittal Pai on 1/24/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import Foundation
import IBMAppLaunch

internal class AppLaunchAdapter {
    
    internal static var sharedInstance = AppLaunchAdapter()
    
    internal func initialize(username: String, userType: String, completionHandler: @escaping AppLaunchCompletionHandler) {
        let config = AppLaunchConfig.Builder().fetchPolicy(.REFRESH_ON_EVERY_START).cacheExpiration(1).eventFlushInterval(100).build()
        let user = AppLaunchUser.Builder(userId: username).custom(key: "type", value: userType).build()
        AppLaunch.sharedInstance.initialize(region: .US_SOUTH, appId: "e5fa93b0-4d0a-4e17-bc91-1189091a9341", clientSecret: "e58862fb-9074-4506-a16d-333c3ab5fabb", config: config, user: user, completionHandler: completionHandler)
    }
    
    internal func isOnlineEyeTestMenuEnabled() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_l9bblng5t")
        } catch {
            return false
        }
    }
    
    internal func getOnlineEyeTestMenuTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_l9bblng5t", propertyCode: "_itchy2x3m")
        } catch {
            return ""
        }
    }
    
    internal func getOnlineEyeTestMenuHeader() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_l9bblng5t", propertyCode: "_itchy2x3m")
        } catch {
            return ""
        }
    }
    
    internal func getOnlineEyeTestButtonTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_l9bblng5t", propertyCode: "_itchy2x3m")
        } catch {
            return ""
        }
    }
    
    internal func sendOnlineEyeTestMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_d2eqdhfu1")
    }
    
    internal func isSubmissionMenuEnabled() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_fffs55wd9")
        } catch {
            return false
        }
    }
    
    internal func getSubmissionMenuTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_fffs55wd9", propertyCode: "_32t5jp929")
        } catch {
            return ""
        }
    }
    
    internal func sendSubmissionMenuPostiveMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_d2eqdhfu1")
    }
    
    internal func sendSubmissionMenuNegativeMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_d2eqdhfu1")
    }
    
    internal func isPrescriptionMenuEnabled() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_5gavnnrf5")
        } catch {
            return false
        }
    }
    
    internal func getPrescriptionMenuTitle() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_5gavnnrf5", propertyCode: "_pqec8f33u")
        } catch {
            return ""
        }
    }
    
    internal func getPrescriptionMenuType() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_5gavnnrf5", propertyCode: "_pqec8f33u")
        } catch {
            return ""
        }
    }
    
    internal func sendPrescriptionMenuMetric() {
        AppLaunchAdapter.sharedInstance.sendMetrics(value: "_d2eqdhfu1")
    }
    
    internal func isBackgroundColorChanged() -> Bool {
        do {
            return try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_u6tm9txnw")
        } catch {
            return false
        }
    }
    
    internal func getBackGroundColor() -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_u6tm9txnw", propertyCode: "_x2ctz0pha")
        } catch {
            return "#FEC058"
        }
    }
    
    internal func displayMessage() {
        do {
            try AppLaunch.sharedInstance.displayMessage()
        } catch {
            
        }
    }
    
    internal func sendMetrics(value: String) {
        do {
            try AppLaunch.sharedInstance.sendMetrics(codes: [value])
        } catch {
            
        }
    }
    
    internal func destroy() {
        AppLaunch.sharedInstance.destroy { (Success, Failure) in
            if(Success != nil) {
                print("Successfully unregistered from AppLaunch Service")
            }
        }
    }
}
