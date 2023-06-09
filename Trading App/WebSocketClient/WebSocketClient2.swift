//
//  WebSocketClient.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 05/06/2023.
//

// The purpose of this class is to provide a foundation for creating a Swift Package Manager (SPM) module that facilitates connecting to a WebSocket server and subscribing to real-time data for multiple stocks. Although currently designed to meet specific requirements, it has the potential to serve as a replacement for the Starscream SPM package as per present needs.


import Foundation

class WebSocketClient: NSObject, URLSessionWebSocketDelegate {
    
    private var webSocketTask: URLSessionWebSocketTask?
    var didFetchedCompanyData: ((Company) -> Void)?
    
    // Connect to the WebSocket server and subscribe to symbols
    func connectAndSubscribe(to symbols: [String]) {
        // Retrieve the API token from the environment variables
        guard let token = ProcessInfo.processInfo.environment["FINNHUB_API_KEY"] else {
            print("FINNHUB_API_KEY environment variable is missing")
            return
        }
        
        // Construct the WebSocket URL with the token
        guard let url = URL(string: "wss://ws.finnhub.io?token=\(token)") else {
            return
        }
        
        // Create a URLSession with WebSocket delegate
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        // Start receiving data from the WebSocket
        receiveData()
        
        // Subscribe to the specified symbols
        subscribeToData(symbols: symbols)
    }
    
    // Receive data from the WebSocket
    private func receiveData() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                // Handle received message
                self?.handleMessage(message: message)
                
                // Continue to receive more data
                self?.receiveData()
            case .failure(let error):
                // Handle error
                print("WebSocket error: \(error)")
            }
        }
    }
    
    // Handle the received message from the WebSocket
    private func handleMessage(message: URLSessionWebSocketTask.Message) {
        switch message {
        case .data(let data):
            // Handle received data
            let jsonString = String(data: data, encoding: .utf8)
            print("Received data: \(jsonString ?? "")")
            
            // You can parse and process the data as needed
        case .string(let text):
            handleData(text)
            
            // You can parse and process the text as needed
        @unknown default:
            break
        }
    }
    
    // Subscribe to the specified symbols
    private func subscribeToData(symbols: [String]) {
        for symbol in symbols {
            subscribe(symbol: symbol)
        }
    }
    
    // Subscribe to a specific symbol
    private func subscribe(symbol: String) {
        let subscriptionMessage = """
        {
            "type": "subscribe",
            "symbol": "\(symbol)"
        }
        """
        send(message: subscriptionMessage)
    }
    
    // Send a message to the WebSocket server
    private func send(message: String) {
        let textMessage = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(textMessage) { error in
            if let error = error {
                // Handle send error
                print("WebSocket send error: \(error)")
            }
        }
    }
    
    // Handle the received data from the WebSocket
    func handleData(_ data: String) {
        // Parse the received WebSocket data
        guard let jsonData = data.data(using: .utf8) else {
            print("Error: Invalid data format")
            return
        }
        do {
            let tradeData = try JSONDecoder().decode(TradeData.self, from: jsonData)
            if let trade = tradeData.data.first {
                let company = Company(acronym: trade.s, updatedPrice: trade.p)
                didFetchedCompanyData?(company)
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
    }
    
    // Disconnect from the WebSocket
    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
}



