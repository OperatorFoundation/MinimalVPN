//
//  VPNManager.swift
//  MinimalVPN
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import Foundation
import Network
import NetworkExtension

public class VPNManager
{
    let manager = NETunnelProviderManager()

    public init() {}

    public func load()
    {
        print("Loading...")

        self.manager.loadFromPreferences
        {
            maybeError in

            print("Loaded.")
        }
    }

    public func enable()
    {
        self.manager.loadFromPreferences
        {
            maybeLoadError in

            print("VPNManager loadFromPreferences - 1")
            if let loadError = maybeLoadError
            {
                print("VPNManager encountered an error loading from preferences: \(loadError)")
            }
            

            self.manager.saveToPreferences
            {
                maybeSaveError in

                print("VPNManager saveToPreferences - 1")

                self.manager.loadFromPreferences
                {
                    maybeNextLoadError in

                    print("VPNManager loadFromPreferences - 2")
                    
                    if let nextLoadError = maybeNextLoadError
                    {
                        print("VPNManager encountered an error on second load from preferences: \(nextLoadError)")
                    }

                    let protocolConfiguration = NETunnelProviderProtocol()
                    protocolConfiguration.providerBundleIdentifier = "\(Bundle.main.bundleIdentifier!).MinimalVPNPacketTunnel"
                    protocolConfiguration.serverAddress = ""
                    protocolConfiguration.includeAllNetworks = true
                    self.manager.protocolConfiguration = protocolConfiguration
                    self.manager.localizedDescription = "MinimalVPN"
                    self.manager.isEnabled = true

                    print("***********\nVPNManager protocolConfiguration:\n\(protocolConfiguration)\n***********")

                    self.manager.saveToPreferences
                    {
                        _ in

                        print("VPNManager saveToPreferences - 2")

                        self.manager.loadFromPreferences
                        {
                            _ in

                            print("VPNManager loadFromPreferences - 3")
                            print("VPNManager enable() is done.")
                        }
                    }
                }
            }
        }
    }
}
