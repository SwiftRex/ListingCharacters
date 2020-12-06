//
//  ContentView.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel =  CharacterListViewModel()
    var body: some View {
        NavigationView {
            List(self.viewModel.characterList) { character in
                CharacterRow(character: character)
            }
            .navigationTitle("Character List")
        }.onAppear {
            self.viewModel.getCharacterList()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
