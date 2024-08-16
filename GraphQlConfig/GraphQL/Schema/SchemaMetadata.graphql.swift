// @generated
// This file was automatically generated and should not be edited.

import Apollo

protocol GraphQL_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == GraphQL.SchemaMetadata {}

protocol GraphQL_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == GraphQL.SchemaMetadata {}

protocol GraphQL_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == GraphQL.SchemaMetadata {}

protocol GraphQL_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == GraphQL.SchemaMetadata {}

extension GraphQL {
  typealias SelectionSet = GraphQL_SelectionSet

  typealias InlineFragment = GraphQL_InlineFragment

  typealias MutableSelectionSet = GraphQL_MutableSelectionSet

  typealias MutableInlineFragment = GraphQL_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    static let configuration: any Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Apollo.Object? {
      switch typename {
      case "Mutation": return GraphQL.Objects.Mutation
      case "loginResponse": return GraphQL.Objects.LoginResponse
      case "Meta": return GraphQL.Objects.Meta
      case "LoginData": return GraphQL.Objects.LoginData
      case "LoginUser": return GraphQL.Objects.LoginUser
      case "Query": return GraphQL.Objects.Query
      case "CountryListResponse": return GraphQL.Objects.CountryListResponse
      case "countryData": return GraphQL.Objects.CountryData
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}