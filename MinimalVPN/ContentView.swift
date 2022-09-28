//
//  ContentView.swift
//  MinimalVPN
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import SwiftUI

struct ContentView: View
{
    let vpn = VPNManager()

    var body: some View
    {
        Text("🫧 MinimalVPN 🫧")
        Button("Connect")
        {
            self.vpn.enable()
            do
            {
                try self.vpn.manager.connection.startVPNTunnel()
            }
            catch
            {
                print("Failed to start the tunnel: \(error)")
            }
        }
        
        Button("Disconnect")
        {
            self.vpn.manager.connection.stopVPNTunnel()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
