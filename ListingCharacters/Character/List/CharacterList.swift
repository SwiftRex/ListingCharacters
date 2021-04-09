//
//  ContentView.swift
//  ListingCharacters
//
//  Created by Jarbas on 05/12/20.
//

import CombineRex
import CombineRextensions
import SwiftUI

struct CharacterList: View {
    @ObservedObject var viewModel: ObservableViewModel<CharacterListViewAction, CharacterListViewState>
    let characterDetails: (Int) -> AnyView

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(
                        viewModel: viewModel,
                        collection: \.rows,
                        identifiableRowToCollectionAction: CharacterListViewAction.item
                    ) { rowViewModel in
                        NavigationLink(
                            destination: characterDetails(rowViewModel.state.id)
                        ) {
                            CharacterRow(viewModel: rowViewModel)
                        }
                    }
                }
            }
            .navigationTitle("Character List")
        }.onAppear {
            self.viewModel.dispatch(.onAppear)
        }
    }
}
//struct CharacterList_Previews: PreviewProvider {

//    static func getViewModel() -> CharacterListViewModel {
//        let viewModel = CharacterListViewModel(serviceProtocolType: CharacterFakeService.self,
//                                               favouritesRepository: FavouriteRepositoryFake())
//        return viewModel
//
//    }
//
//    static var previews: some View {
//        CharacterList(viewModel: getViewModel() )
//    }
//}
