//
//  PacketTunnelProvider.swift
//  MinimalVPNPacketTunnel
//
//  Created by Dr. Brandon Wiley on 6/1/22.
//

import Logging
import Network
import NetworkExtension

class MinimalVPNPacketTunnel: NEPacketTunnelProvider {
    var logger: Logger
    var connection: NWTCPConnection! = nil

    public override init()
    {
        self.logger = Logger(label: "MinimalVPNPacketTunnelLog")
        self.logger.logLevel = .debug

        self.logger.debug("Initialized MinimalVPNPacketTunnel")

        super.init()
    }

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        completionHandler(nil)

        self.connection = self.createTCPConnection(to: NWHostEndpoint(hostname: "", port: "1234"), enableTLS: false, tlsParameters: nil, delegate: nil)
        
        self.logger.debug("startTunnel created a connection. Connection state: \(connection.state)")
        
        self.connection.write("hello".data(using: .utf8)!)
        {
            maybeWriteError in

            if let writeError = maybeWriteError
            {
                self.logger.error("startTunnel received an error trying to write to the connection: \(writeError)")
            }
            else
            {
                self.logger.debug("startTunnel wrote some data")
            }
            //return
        }

//        connection.stateUpdateHandler =
//        {
//            (state: NWConnection.State) in
//
//            self.logger.debug("state: \(state)")
//            switch state
//            {
//                case .ready:
//                    self.logger.debug("ready!")
//                    completionHandler(nil)
//                case .cancelled:
//                    completionHandler(nil)
//                case .failed(_):
//                    completionHandler(nil)
//                default:
//                    return
//            }
//        }
    }
        
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Add code here to start the process of stopping the tunnel.
        completionHandler()
    }
    
    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Add code here to handle the message.
        if let handler = completionHandler {
            handler(messageData)
        }
    }
    
    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
    }
    
    override func wake() {
        // Add code here to wake up.
    }
}
