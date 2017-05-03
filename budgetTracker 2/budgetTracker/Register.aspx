<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="budgetTracker.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration Page</title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/Custom.css" />
</head>
<body>
    <div class="container maxWidthContainerSm">
        <form id="budgetTrackerRegister" runat="server" class="form-horizontal">
            <h1 class="disInlineBlock">Budget Tracker Registration</h1>
            <a href="Login.aspx" class="btn btn-primary menuBtn" title="Login Page">Login Page</a>
            <hr />
            <asp:Label ID="updateStatusPanel" runat="server" CssClass="disNone">
                <asp:Label ID="updateStatusHead" runat="server" Text="" CssClass="disNone"></asp:Label>
            </asp:Label>
            <div class="form-group">
                <label class="control-label col-sm-2" for="currentName">Username: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="rUserNameBox" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqUsername" runat="server" ErrorMessage="Please enter a username." 
                                                ControlToValidate="rUserNameBox" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="currentName">Email: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="rEmailBox" runat="server" class="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqEmail" runat="server" ErrorMessage="Please enter an email." 
                                                ControlToValidate="rEmailBox" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    <asp:regularexpressionvalidator ID="regExEmail" ControlToValidate="rEmailBox" runat="server" errormessage="Please enter a valid email."
                                                    ValidationExpression="^\S+@\S+$" Display="Dynamic" CssClass="text-danger"></asp:regularexpressionvalidator>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="currentName">Password: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="rPasswordBox" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPassword" runat="server" ErrorMessage="Please enter a password." 
                                                ControlToValidate="rPasswordBox" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="currentName">Confirm Password: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="confirmPasswordBox" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqConfirmPass" runat="server" ErrorMessage="Please confirm password." 
                                                ControlToValidate="confirmPasswordBox" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="confirmPassComp" runat="server" ErrorMessage="Passwords must be equal." ControlToCompare="rPasswordBox" 
                                            ControlToValidate="confirmPasswordBox" Display="Dynamic" CssClass="text-danger"></asp:CompareValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="registerButton" runat="server" class="btn btn-primary btn-space" Text="Register" OnClick="registerButton_Click" CausesValidation="true" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>
