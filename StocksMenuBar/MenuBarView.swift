//
//  MenuBarView.swift
//  StocksMenuBar
//
//  Created by Marcelo Sampaio on 01/08/24.
//

import SwiftUI

struct MenuBarView: View {
    @StateObject private var vm: StockListViewModel
    
    init(vm: StockListViewModel) {
        self._vm = StateObject(wrappedValue: vm)
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Stocks").padding()
            
            List(vm.stocks, id: \.symbol) { stock in
                HStack {
                    VStack {
                        Text(stock.symbol)
                            .fontWeight(.semibold)
                        
                        Text(stock.description)
                            .opacity(0.4)
                        
//                        Divider()
                    }
                    
                    Spacer()
                    
                    Text(stock.price.formatAsCurrency())
                }
            }
            .frame(width: 300, height: 300)
            .task {
                await vm.populateStocks()
            }
        }
        
        
    }
}

#Preview {
    MenuBarView(vm: StockListViewModel.init())
}
