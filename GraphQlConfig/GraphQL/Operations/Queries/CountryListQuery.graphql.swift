// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GraphQL {
  class CountryListQuery: GraphQLQuery {
    static let operationName: String = "CountryList"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"query CountryList { CountryList { __typename meta { __typename status message message_code status_code } data { __typename uuid name country_code phone_code is_default } } }"#
      ))

    public init() {}

    struct Data: GraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any Apollo.ParentType { GraphQL.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("CountryList", CountryList?.self),
      ] }

      var countryList: CountryList? { __data["CountryList"] }

      /// CountryList
      ///
      /// Parent Type: `CountryListResponse`
      struct CountryList: GraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any Apollo.ParentType { GraphQL.Objects.CountryListResponse }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("meta", Meta.self),
          .field("data", [Datum?]?.self),
        ] }

        var meta: Meta { __data["meta"] }
        var data: [Datum?]? { __data["data"] }

        /// CountryList.Meta
        ///
        /// Parent Type: `Meta`
        struct Meta: GraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any Apollo.ParentType { GraphQL.Objects.Meta }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("status", Bool.self),
            .field("message", String.self),
            .field("message_code", String.self),
            .field("status_code", Int.self),
          ] }

          var status: Bool { __data["status"] }
          var message: String { __data["message"] }
          var message_code: String { __data["message_code"] }
          var status_code: Int { __data["status_code"] }
        }

        /// CountryList.Datum
        ///
        /// Parent Type: `CountryData`
        struct Datum: GraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any Apollo.ParentType { GraphQL.Objects.CountryData }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("uuid", String?.self),
            .field("name", String?.self),
            .field("country_code", String?.self),
            .field("phone_code", String?.self),
            .field("is_default", Bool?.self),
          ] }

          var uuid: String? { __data["uuid"] }
          var name: String? { __data["name"] }
          var country_code: String? { __data["country_code"] }
          var phone_code: String? { __data["phone_code"] }
          var is_default: Bool? { __data["is_default"] }
        }
      }
    }
  }
}