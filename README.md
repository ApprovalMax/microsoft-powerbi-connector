# ApprovalMax Public Power BI API Connector

### Requirements
* Visual Studio Code
* Power Query SDK Extension for the VS Code v0.2.3 ([link](https://marketplace.visualstudio.com/items?itemName=Dakahn.PowerQuerySDK))
* Power Query/M Language Extension for the VS Code v.0.1.53 ([link](https://marketplace.visualstudio.com/items?itemName=PowerQuery.vscode-powerquery))
* Power BI Desktop

### How to compile a connector
1. Ensure to install all the pre-requisites and copy the files from the PBI_Connector folder into a new VS Code project
2. Create a new application at the ApprovalMax's [developer portal](https://developer.approvalmax.com/)
   1. Make sure to input https://oauth.powerbi.com/views/oauthredirect.html as the redirect URL
   2. Make sure to copy your Client ID and Client Secret. Please, ensure to keep the Client Secret **confidential**. Note, that it cannot be regenerated or copied again
3. Open the cloned official repository and input your Client ID and Client Secret into the corresponding txt files. Make sure to replace the <YOUR_CLIENT_ID> and <YOUR_CLIENT_SECRET> placeholders without modifying the ID and Secret.
   1. Client ID -> client_id.txt 
   2. Client Secret -> client_secret.txt
4. Ensure to save the changes
5. In the VS Code, run a build task in order to compile the connector. This can be done via the menu (Terminal -> Run Build Task) or via the shortcut (Ctrl + Shift + B). Then select the MakePQX option.
6. After these steps, a .mez file would appear in the "PROJECTFOLDER\bin\AnyCPU\Debug\ApprovalMaxConnector.mez". This is the compiled connector.

### How to set up Power BI to use custom connector
The next steps follow the official guideline ([link](https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-connector-extensibility))
1. If it does not exist yet, create a folder [Documents]/Power BI Desktop/Custom Connectors and put the compiled .mez file into it
2. Start you Power BI Desktop and allow custom connectors to be used by going into File -> Options and Settings -> Options -> Security and select (Not Recommended) Allow any extension to load without validation or warning option. Click "OK" in the bottom and restart the Power BI Desktop 
3. Once you restart, a connector-related warning window could pop-up. Just click **OK**

### Getting the data
1. In Power BI go Home -> Get data -> More..., then find and choose the **ApprovalMaxConnector (Beta)** in the list
2. In the appeared window, click on sign-in button which will redirect you to the login webpage. Log into your account and provide consent to the wanted companies. Next, click continue. Finally, please provide a link to the endpoint, which you wish to use. Please, refer to [ApprovalMax Public API](https://public-api.approvalmax.com/swagger/index.html) for more details about each API Method.
   1. Note that at this step, you need to provide the consent to request the data for the selected companies. If you face any issues during this step, try to repeat it
3. If there is a connection already established, the connector won’t ask you to login again
4. Utilise the [Power Query Syntax](https://learn.microsoft.com/en-us/powerquery-m/) in order to load the data into the actual Power BI Workspace