// This file contains your Data Connector logic
[Version = "1.0.0"]
section ApprovalMaxConnector;

// ApprovalMax OAuth2 values
client_id = Text.FromBinary(Extension.Contents("client_id.txt"));
client_secret = Text.FromBinary(Extension.Contents("client_secret.txt"));
redirect_uri = "https://oauth.powerbi.com/views/oauthredirect.html";
token_uri = "https://identity.approvalmax.com/connect/token";
authorize_uri = "https://identity.approvalmax.com/connect/authorize";
logout_uri = "https://login.microsoftonline.com/logout.srf";

// Login modal window dimensions
windowWidth = 720;
windowHeight = 1024;

[DataSource.Kind="ApprovalMaxConnector", Publish="ApprovalMaxConnector.Publish"]
shared ApprovalMaxConnector.Contents = (url as text) =>
    let
        source = Json.Document(Web.Contents(url))
    in
        source; 

// OAuth2 scope
scope_prefix = "";
scopes = {
    "https://www.approvalmax.com/scopes/public_api/read",
    "https://www.approvalmax.com/scopes/public_api/write",
    "offline_access"
};

// Data Source Kind description
ApprovalMaxConnector = [
    TestConnection = (dataSourcePath) => { "ApprovalMaxConnector.Contents", dataSourcePath },
    Authentication = [
        OAuth = [
            StartLogin=StartLogin,
            FinishLogin=FinishLogin,
            Refresh=Refresh,
            Logout=Logout
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
ApprovalMaxConnector.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = ApprovalMaxConnector.Icons,
    SourceTypeImage = ApprovalMaxConnector.Icons
];

StartLogin = (resourceUrl, state, display) =>
    let
        AuthorizeUrl = authorize_uri & "?" & Uri.BuildQueryString([
            response_type = "code",
            client_id = client_id,  
            scope = GetScopeString(scopes, scope_prefix),
            redirect_uri = redirect_uri,
            state = state
        ])

    in
        [
            LoginUri = AuthorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = 720,
            WindowWidth = 1024,
            Context = null
        ];

FinishLogin = (context, callbackUri, state) =>
    let
        parts = Uri.Parts(callbackUri as text)[Query],
        result = TokenMethod("authorization_code", "code", parts[code])
    in
        result;

Refresh = (resourceUrl, refresh_token) => TokenMethod("refresh_token", "refresh_token", refresh_token);

Logout = (token) => logout_uri;


TokenMethod = (grantType, tokenField, code_extracted) =>
    let
        queryString = [
            grant_type = grantType,
            redirect_uri = redirect_uri,
            client_id = client_id,
            client_secret = client_secret
        ],

        queryWithCode = Record.AddField(queryString, tokenField, code_extracted),

        tokenResponse = Web.Contents(token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(queryWithCode)),
            Headers = [
                #"Content-Type" = "application/x-www-form-urlencoded"
            ]
        ]),
        result = Json.Document(tokenResponse)
    in
        result;

Value.IfNull = (a, b) => if a <> null then a else b;

GetScopeString = (scopes as list, optional scopePrefix as text) as text =>
    let
        prefix = Value.IfNull(scopePrefix, ""),
        addPrefix = List.Transform(scopes, each prefix & _),
        asText = Text.Combine(addPrefix, " ")
    in
        asText;

ApprovalMaxConnector.Icons = [
    Icon16 = { Extension.Contents("ApprovalMaxConnector16.png"), Extension.Contents("ApprovalMaxConnector20.png"), Extension.Contents("ApprovalMaxConnector24.png"), Extension.Contents("ApprovalMaxConnector32.png") },
    Icon32 = { Extension.Contents("ApprovalMaxConnector32.png"), Extension.Contents("ApprovalMaxConnector40.png"), Extension.Contents("ApprovalMaxConnector48.png"), Extension.Contents("ApprovalMaxConnector64.png") }
];
