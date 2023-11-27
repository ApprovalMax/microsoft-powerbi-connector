# ApprovalMax Public Power BI API Connector

### Requirements
* Visual Studio Code
* Power Query SDK Extension for the VS Code v0.2.3
* Power Query/M Language Extension for the VS Code v.0.1.53
* Power BI Desktop

### How to compile a connector
1. Create a new application at the ApprovalMax's [developer portal](https://developer.approvalmax.com/)
   1. Make sure to input https://oauth.powerbi.com/views/oauthredirect.html as the redirect URL
   2. Make sure to copy your Client ID and Client Secret. Please, ensure to keep the Client Secret **confidential**. Note, that it cannot be regenerated or copied again
2. Open the cloned official repository and input your Client ID and Client Secret into the corresponding txt files. Make sure to replace the <YOUR_CLIENT_ID> and <YOUR_CLIENT_SECRET> placeholders without modifying the ID and Secret.
   1. Client ID -> client_id.txt 
   2. Client Secret -> client_secret.txt
3. Ensure to save the changes
4. In the VS Code, run a build task in order to compile the connector. This can be done via the menu (Terminal -> Run Build Task) or via the shortcut (Ctrl + Shift + B). Then select the MakePQX option.
5. After these steps, a .mez file would appear in the "PROJECTFOLDER\bin\AnyCPU\Debug\ApprovalMaxConnector.mez". This is the compiled connector.

### How to set up Power BI to use custom connector
The next steps follow the official guideline ([link](https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-connector-extensibility))
1. If it does not exist yet, create a folder [Documents]/Power BI Desktop/Custom Connectorsand put the compiled .mez file into it
2. Start you Power BI Desktop and allow custom connectors to be used by going into File -> Options and Settings -> Options -> Security and select (Not Recommended) Allow any extension to load without validation or warning option. Click "OK" in the bottom and restart the Power BI Desktop 
3. Once you restart, a warning window would pop-up. Just click **OK**

### Getting the data
1. In Power BI go Home -> Get data -> More..., then find and choose the **ApprovalMaxConnector (Beta)** in the list
2. In the appeared window, please provide a link to the endpoint, which you wish to use. Please, refer to [ApprovalMax Public API](https://public-api.approvalmax.com/swagger/index.html) for more details about each API Method. After you input the link, follow the regular login procedure.
3. If there is a connection already established, the connector won’t ask you to login again
4. Utilise the [Power Query Syntax](https://learn.microsoft.com/en-us/powerquery-m/) in order to load the data into the actual Power BI Workspace