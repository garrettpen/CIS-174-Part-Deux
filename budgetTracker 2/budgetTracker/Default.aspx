﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="budgetTracker.Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Budget Tracker</title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Content/Custom.css" />
    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/main.js"></script>
</head>
<body>
    <div class="container">
        <form id="budgetTrackerForm" runat="server" class="form-horizontal">
            <h1 class="disInlineBlock">Budget Tracker</h1>
            <a href="ProfilePage.aspx" class="btn btn-primary menuBtn" title="Profile Page">Edit Profile</a>
            <asp:Button ID="logOutBtn" runat="server" OnClick="logOutBtn_Click" 
                    Text="Log Out" CssClass="btn btn-primary menuBtn" />
            <hr />
            <!-- Salary Input Fields -->
            <h2>Salary Information</h2>
            <hr />
            <div class="form-group">
                <label class="control-label col-sm-2" for="salaryInput">Please input monthly salary: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="salaryInput" class="form-control" runat="server" ></asp:TextBox>
                </div>
                <div class="text-danger col-sm-offset-2 col-sm-10 error">
                    <asp:RequiredFieldValidator ID="reqSalaryInput" runat="server" ErrorMessage="Please enter a salary amount." 
                                                ControlToValidate="salaryInput" ValidationGroup="salaryGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:regularexpressionvalidator ID="regExSalaryInput" ControlToValidate="salaryInput" ValidationGroup="salaryGroup" runat="server" errormessage="Please enter a valid number."
                                                    ValidationExpression="^[ ]*[\-]?[0-9]*[\.]?[0-9]*[ ]*$" Display="Dynamic"></asp:regularexpressionvalidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="saveSalaryButton" runat="server" OnClick="saveSalaryButton_Click" 
                                ValidationGroup="salaryGroup" Text="Add to Salary" CssClass="btn btn-primary" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    Total Salary Amount: <asp:Label ID="monthlySalaryLabel" runat="server" Text="$0.00"></asp:Label>
                </div>
            </div>
            <!-- END: Salary Input Fields -->

            <!-- Expense Input Fields -->
            <h2>Expense Information</h2>
            <hr />
            <div class="form-group">
                <label class="control-label col-sm-2" for="ddlExpenseCategory">Please select an expense category: </label>
                <div class="col-sm-10">
                    <asp:dropdownlist runat="server" id="ddlExpenseCategory" class="form-control">
                        <asp:ListItem Value="other">Other</asp:ListItem>
                        <asp:ListItem Value="home">Home</asp:ListItem>
                        <asp:ListItem Value="auto">Auto</asp:ListItem>
                        <asp:ListItem Value="entertainment">Entertainment</asp:ListItem>
                        <asp:ListItem Value="food">Food</asp:ListItem>
                    </asp:dropdownlist>
                </div>
                <div class="text-danger col-sm-offset-2 col-sm-10 error">
                    <asp:RequiredFieldValidator ID="reqDdlExpenseCategory" runat="server" ErrorMessage="Please enter a category." 
                                                ControlToValidate="ddlExpenseCategory" ValidationGroup="expenseGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="expenseNameInput">Please input name of monthly expense: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="expenseNameInput" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="text-danger col-sm-offset-2 col-sm-10 error">
                    <asp:RequiredFieldValidator ID="reqExpenseNameInput" runat="server" ErrorMessage="Please enter an expense name." 
                                                ControlToValidate="expenseNameInput" ValidationGroup="expenseGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="expenseAmountInput">Please enter amount of expense: </label>
                <div class="col-sm-10">
                    <asp:TextBox ID="expenseAmountInput" class="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="text-danger col-sm-offset-2 col-sm-10 error">
                    <asp:RequiredFieldValidator ID="reqExpenseAmountInput" runat="server" ErrorMessage="Please enter an expense amount." 
                                                ControlToValidate="expenseAmountInput" ValidationGroup="expenseGroup" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:regularexpressionvalidator ID="regExExpenseAmountInput" ControlToValidate="expenseAmountInput" ValidationGroup="expenseGroup" runat="server" errormessage="Please enter a valid number."
                                                    ValidationExpression="^[ ]*[\-]?[0-9]*[\.]?[0-9]*[ ]*$" Display="Dynamic"></asp:regularexpressionvalidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="addExpenseButton" runat="server" OnClick="addExpenseButton_Click" 
                                ValidationGroup="expenseGroup" Text="Add Expense" CssClass="btn btn-primary" />
                </div>
            </div>
            <!-- END: Expense Input Fields -->

            <h2>Added Expenses</h2>
            <hr />
            <!-- pie chart creation *Need to figure out how to connect data source and get percentages figured out -->
            <div class="col-xs-4">
                <asp:Chart ID="crtExpenses" Name="Expenses" runat="server" DataSourceID="SqlDataSource1" ToolTip="Expense Pie Chart">
                    <Series>
                       <asp:Series Name="Series1" ChartType="Pie" YValueMembers="expAmount" XValueMember="expCategory"></asp:Series>
                   </Series>
                   <ChartAreas>
                       <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                   </ChartAreas>
               </asp:Chart>
            </div>

           <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UserDataConnectionString %>" SelectCommand="SELECT SUM([expAmount]) 'expAmount', [expCategory] FROM [expense] WHERE ([userName] = @userName) GROUP BY [expCategory]">
               <SelectParameters>
                   <asp:SessionParameter Name="userName" SessionField="userName" Type="String" />
               </SelectParameters>
           </asp:SqlDataSource>

            <div class="col-xs-8">
                <asp:GridView ID="expenseGrid" runat="server" DataSourceID="expenseDataSource" AllowPaging="True" 
                              AutoGenerateColumns="False" CssClass="table table-striped table-bordered" 
                              OnRowDeleted="expenseGrid_RowDeleted" OnRowUpdated="expenseGrid_RowUpdated">
                    <Columns>
                        <asp:BoundField DataField="ExpenseId" HeaderText="ID" ReadOnly="True" SortExpression="ProductID" />
                        <asp:TemplateField HeaderText="Category" SortExpression="Category">
                            <EditItemTemplate>
                                <asp:dropdownlist runat="server" id="categoryEdt" class="form-control" 
                                                  SelectedValue='<%# Bind("ExpCategory") %>'>
                                    <asp:ListItem Value="other">Other</asp:ListItem>
                                    <asp:ListItem Value="home">Home</asp:ListItem>
                                    <asp:ListItem Value="auto">Auto</asp:ListItem>
                                    <asp:ListItem Value="entertainment">Entertainment</asp:ListItem>
                                    <asp:ListItem Value="food">Food</asp:ListItem>
                                </asp:dropdownlist>
                                <asp:RequiredFieldValidator ID="reqDdlExpenseCategory" runat="server" ErrorMessage="Please enter a category." 
                                                        ControlToValidate="categoryEdt" ValidationGroup="expEdtGroup" Display="None"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="categoryEdtLabel" runat="server" Text='<%# Bind("ExpCategory") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" SortExpression="Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="nameEdt" runat="server" class="form-control" Text='<%# Bind("ExpName") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqExpenseNameEdt" runat="server" ErrorMessage="Please enter an expense name." 
                                                        ControlToValidate="nameEdt" ValidationGroup="expEdtGroup" Display="None"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="nameEdtLabel" runat="server" Text='<%# Bind("ExpName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                            <EditItemTemplate>
                                <asp:TextBox ID="amountEdt" runat="server" class="form-control" Text='<%# Bind("ExpAmount") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqExpenseAmountEdt" runat="server" ErrorMessage="Please enter an expense amount." 
                                                        ControlToValidate="amountEdt" ValidationGroup="expEdtGroup" Display="None"></asp:RequiredFieldValidator>
                                <asp:regularexpressionvalidator ID="regExExpenseAmountEdt" ControlToValidate="amountEdt" ValidationGroup="expEdtGroup" runat="server" errormessage="Please enter a valid number."
                                                            ValidationExpression="^[ ]*[\-]?[0-9]*[\.]?[0-9]*[ ]*$" Display="None"></asp:regularexpressionvalidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="amountEdtLabel" runat="server" Text='<%# Bind("ExpAmount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ExpPercent" HeaderText="Percentage" SortExpression="Percentage" ReadOnly="True" />
                        <asp:CommandField ButtonType="Link" ShowEditButton="true" ItemStyle-CssClass="center-text" ControlStyle-CssClass="glyphicon glyphicon-pencil" 
                                          EditText="" CausesValidation="true" ValidationGroup="expEdtGroup"  />
                        <asp:CommandField ButtonType="Link" ShowDeleteButton="True" ItemStyle-CssClass="center-text" ControlStyle-CssClass="glyphicon glyphicon-trash" 
                                          DeleteText="" />
                    </Columns>
                </asp:GridView>
            </div>
            <asp:ObjectDataSource ID="expenseDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetExpenses" 
                                  UpdateMethod="UpdateExpense" DeleteMethod="DeleteExpense" OnUpdated="expenseDataSource_Updated"
                                  OnDeleted="expenseDataSource_Deleted" ConflictDetection="CompareAllValues" 
                                  TypeName="budgetTracker.ExpenseDB">
                <SelectParameters>
                    <asp:SessionParameter Name="userName" SessionField="userName" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:SessionParameter Name="userName" SessionField="userName" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:SessionParameter Name="userName" SessionField="userName" />
                </DeleteParameters>
            </asp:ObjectDataSource>
            <p>
              <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
            </p>
                <asp:ValidationSummary ID="validationSummary" runat="server"
                    HeaderText="Please correct the following errors:" CssClass="text-danger" ValidationGroup="expEdtGroup" />
            <!-- END: Expense Output Result -->
        </form>
    </div>
</body>
</html>
