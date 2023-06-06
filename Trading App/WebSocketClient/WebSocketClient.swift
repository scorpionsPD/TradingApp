//
//  WebSocketClient.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation
import Starscream

class FinnhubWebSocketClient: WebSocketDelegate {
    var socket: WebSocket?
    var didFetchedCompanyData:((Company)->Void)?
    
    func connect() {
        let request = URLRequest(url: URL(string: "wss://ws.finnhub.io?token=chvefopr01qrqeng5q7gchvefopr01qrqeng5q80")!)
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected:
            print("WebSocket connected")
            subscribeToData()
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            handleData(string)
        default:
            break
        }
    }
    
    func subscribeToData() {
        subscribe(symbol: "AAPL")
        subscribe(symbol: "TSLA")
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
            if let trade = tradeData.data.last {
                let company = Company(acronym: trade.s, updatedPrice: trade.p)
                didFetchedCompanyData?(company)
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
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
