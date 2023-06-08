# TradingApp
Universal stock tracker iOS app that supports all orientations. It should display real- time trades updates for US Stock, forex and crypto by using Finnhub API's.

**To configure finnhub api key please follow these steps:** 

Step 1: Open your Xcode project and go to the “Edit Scheme” menu. This can be found by clicking on the “Product” menu in the top menu bar and selecting “Scheme > Edit Scheme."

Step 2: Select the “Run” option in the left-hand menu, and then click on the “Arguments” tab.

Step 3: Click on the "+" button in the “Environment Variables” section to add a new variable.

Step 4: Enter the name of your API key in the “Name” field as "FINNHUB_API_KEY" and the actual key in the “Value” field.

**To setup symbols to subscribe please do setup in Constants.swift file:**

for example: static let symbols = ["AAPL", "TSLA", "AMZN"]
