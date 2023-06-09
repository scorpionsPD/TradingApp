//
//  WebSocketClient.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation
import Starscream

class FinnhubWebSocketClient {
    private var socket: WebSocket?
    private var subscribeSymbols: [String]?
    var didFetchedCompanyData:((Company)->Void)?
    
    init(subscribeSymbols: [String]) {
        
        guard let token = ProcessInfo.processInfo.environment["FINNHUB_API_KEY"] else {
            print("FINNHUB_API_KEY environment variable is missing")
            return
        }
        
        // Construct the URL for the API request
        var urlComponents = URLComponents(string: "wss://ws.finnhub.io?token=\(token)")
        urlComponents?.queryItems = [
            URLQueryItem(name: "token", value: token)
        ]
        
        guard let url = urlComponents?.url else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
        
        self.subscribeSymbols = subscribeSymbols
    }

    func connect() {
        socket?.connect()
    }
    
    private func subscribeToData(symbols: [String]) {
        for symbol in symbols {
            subscribe(symbol: symbol)
        }
    }

    private func subscribe(symbol: String) {
        let json = ["type": "subscribe", "symbol": symbol]
        let data = try! JSONEncoder().encode(json)
        socket?.write(data: data)
    }

    private func handleData(_ data: String) {
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
}

extension FinnhubWebSocketClient: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected:
            print("WebSocket connected")
            if let symbols = subscribeSymbols {
                subscribeToData(symbols: symbols)
            }
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            handleData(string)
        default:
            break
        }
    }
}
// MARK: Modal

struct TradeData: Codable {
    let data: [Trade]
    let type: String
}

struct Trade: Codable {
    let c: [String]
    let p: Double
    let s: String
    let t: Int
    let v: Int
}
