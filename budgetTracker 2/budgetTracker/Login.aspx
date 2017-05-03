<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="budgetTracker.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/Custom.css" />
</head>
<body>
    <div class="container maxWidthContainerSm">
        <form id="budgetTrackerLogin" runat="server" class="form-horizontal">
            <h1>Budget Tracker Login</h1>
            <hr />
            <asp:Label ID="updateStatusPanel" runat="server" CssClass="disNone">
                <asp:Label ID="updateStatusHead" runat="server" Text="" CssClass="disNone"></asp:Label>
            </asp:Label>
            <div class="form-group">
                <label class="control-label col-sm-2" for="currentName">Username: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="userNameBox" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="currentName">Password: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="passwordBox" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="loginBtn" runat="server" class="btn btn-primary btn-space" Text="Login" OnClick="loginButton_Click" />
                </div>
            </div>
            <p class="col-sm-offset-2">Not yet a member? Click <a href="Register.aspx">HERE</a> to register!</p>
        </form>
    </div>
</body>
</html>
