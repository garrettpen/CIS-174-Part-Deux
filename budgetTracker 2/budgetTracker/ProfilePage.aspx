<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="budgetTracker.ProfilePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile</title>
    <link rel="stylesheet" type="text/css" href="content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="content/Custom.css" />
</head>
<body>
    <div class="container maxWidthContainerMd">
        <form id="profilePageForm" runat="server" class="form-horizontal">
            <h1 class="disInlineBlock">Profile Page</h1>
            <a href="Default.aspx" class="btn btn-primary menuBtn" title="Budget Tracker">Budget Tracker</a>
            <asp:Button ID="logOutBtn" runat="server" OnClick="logOutBtn_Click" 
                    Text="Log Out" CssClass="btn btn-primary menuBtn" />
            <hr />
            <asp:Label ID="updateStatusPanel" runat="server" CssClass="disNone">
                <asp:Label ID="updateStatusHead" runat="server" Text="" CssClass="disNone"></asp:Label>
            </asp:Label>
            <div class="form-group">
                <label class="control-label col-sm-2" for="currentName">Current Username: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="currentName" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="newName">New Username: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="newName" runat="server" class="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="confirmName">Re-enter new Username: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="confirmName" runat="server" class="form-control"></asp:TextBox>
                    <asp:CompareValidator ID="confirmNameComp" runat="server" ErrorMessage="Usernames must be equal." ControlToCompare="newName" 
                                            ControlToValidate="confirmName" Display="Dynamic" CssClass="text-danger"></asp:CompareValidator>
                    <asp:Label ID="userNameTaken" runat="server" Text="" CssClass="text-danger"></asp:Label>
                </div>
            </div>
        <!--<div class="form-group">
                <label class="control-label col-sm-2" for="currPassword">Current Password: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="currPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                </div>
            </div>-->
            <div class="form-group">
                <label class="control-label col-sm-2" for="newPassword">New Password: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="newPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="confirmPassword">Re-enter New Password: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="confirmPassword" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                    <asp:CompareValidator ID="confirmPassComp" runat="server" ErrorMessage="Passwords must be equal." ControlToCompare="newPassword" 
                                            ControlToValidate="confirmPassword" Display="Dynamic" CssClass="text-danger"></asp:CompareValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="updProfile" runat="server" OnClick="updProfile_Click" 
                                Text="Update" CssClass="btn btn-primary" CausesValidation="true" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>
