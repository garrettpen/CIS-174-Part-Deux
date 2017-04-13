<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="budgetTracker.ProfilePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
        <p>
&nbsp;
            <asp:Label ID="currNameLbl" runat="server" Text="Current Username"></asp:Label>
            :
            <asp:TextBox ID="currentName" runat="server" Height="19px" Width="161px"></asp:TextBox>
        </p>
        <p>
&nbsp;
            <asp:Label ID="newNameLbl" runat="server" Text="New Username"></asp:Label>
&nbsp;
            <asp:TextBox ID="newName" runat="server" Width="158px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="reenterNameLbl" runat="server" Text="Re-enter new Username:"></asp:Label>
&nbsp;<asp:TextBox ID="confirmName" runat="server" Width="155px"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Label ID="currPasswordLbl" runat="server" Text="Current Password:"></asp:Label>
&nbsp;
            <asp:TextBox ID="currentPassword" runat="server" Width="151px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="newPasswordLbl" runat="server" Text="New Password:"></asp:Label>
&nbsp;
            <asp:TextBox ID="newPassword" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="reenterPasswordLbl" runat="server" Text="Re-enter New Password:"></asp:Label>
&nbsp;<asp:TextBox ID="confirmPassword" runat="server" Width="167px"></asp:TextBox>
        </p>
    </form>
</body>
</html>
