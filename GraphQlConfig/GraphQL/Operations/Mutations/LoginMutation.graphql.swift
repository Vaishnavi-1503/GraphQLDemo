// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension GraphQL {
  class LoginMutation: GraphQLMutation {
    static let operationName: String = "login"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation login($email: String!, $password: String!) { login(input: { email: $email, password: $password }) { __typename meta { __typename status message message_code status_code } data { __typename token_type expires_in access_token refresh_token user { __typename uuid first_name last_name email mobile_number phone_country_id status completed is_mobile_verified is_email_verified avatar chat_jwt_token chat_id id } } } }"#
      ))

    public var email: String
    public var password: String

    public init(
      email: String,
      password: String
    ) {
      self.email = email
      self.password = password
    }

    public var __variables: Variables? { [
      "email": email,
      "password": password
    ] }

    struct Data: GraphQL.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any Apollo.ParentType { GraphQL.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("login", Login.self, arguments: ["input": [
          "email": .variable("email"),
          "password": .variable("password")
        ]]),
      ] }

      var login: Login { __data["login"] }

      /// Login
      ///
      /// Parent Type: `LoginResponse`
      struct Login: GraphQL.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any Apollo.ParentType { GraphQL.Objects.LoginResponse }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("meta", Meta.self),
          .field("data", Data.self),
        ] }

        var meta: Meta { __data["meta"] }
        var data: Data { __data["data"] }

        /// Login.Meta
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

        /// Login.Data
        ///
        /// Parent Type: `LoginData`
        struct Data: GraphQL.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any Apollo.ParentType { GraphQL.Objects.LoginData }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("token_type", String.self),
            .field("expires_in", String.self),
            .field("access_token", String.self),
            .field("refresh_token", String.self),
            .field("user", User?.self),
          ] }

          var token_type: String { __data["token_type"] }
          var expires_in: String { __data["expires_in"] }
          var access_token: String { __data["access_token"] }
          var refresh_token: String { __data["refresh_token"] }
          var user: User? { __data["user"] }

          /// Login.Data.User
          ///
          /// Parent Type: `LoginUser`
          struct User: GraphQL.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any Apollo.ParentType { GraphQL.Objects.LoginUser }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("uuid", String.self),
              .field("first_name", String?.self),
              .field("last_name", String?.self),
              .field("email", String.self),
              .field("mobile_number", String?.self),
              .field("phone_country_id", String?.self),
              .field("status", String?.self),
              .field("completed", String?.self),
              .field("is_mobile_verified", String?.self),
              .field("is_email_verified", String?.self),
              .field("avatar", String?.self),
              .field("chat_jwt_token", String?.self),
              .field("chat_id", String?.self),
              .field("id", Int?.self),
            ] }

            var uuid: String { __data["uuid"] }
            var first_name: String? { __data["first_name"] }
            var last_name: String? { __data["last_name"] }
            var email: String { __data["email"] }
            var mobile_number: String? { __data["mobile_number"] }
            var phone_country_id: String? { __data["phone_country_id"] }
            var status: String? { __data["status"] }
            var completed: String? { __data["completed"] }
            var is_mobile_verified: String? { __data["is_mobile_verified"] }
            var is_email_verified: String? { __data["is_email_verified"] }
            var avatar: String? { __data["avatar"] }
            var chat_jwt_token: String? { __data["chat_jwt_token"] }
            var chat_id: String? { __data["chat_id"] }
            var id: Int? { __data["id"] }
          }
        }
      }
    }
  }
}