<%@ Page Title="" Language="C#" MasterPageFile="~/main.Master" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="BlossomsWeb.signup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="margin: auto;padding: 30px">
    <h2>New Society Registration </h2>

    <asp:Panel ID="pnlForm" runat="server">
    <div class="form-group">
        <asp:Label ID="lblSocietyName" runat="server" AssociatedControlID="txtSocietyName">Name of the society:</asp:Label>
        <asp:TextBox ID="txtSocietyName" runat="server" CssClass="form-control" Required="true"></asp:TextBox>
    </div>

    <div class="form-group">
        <asp:Label ID="lblConstitution" runat="server" AssociatedControlID="fuConstitution">Constitution of the society:</asp:Label>
        <asp:FileUpload ID="fuConstitution" runat="server" CssClass="form-control" Required="true" />
    </div>

    <div class="form-group">
        <asp:Label ID="lblExecutiveList" runat="server" AssociatedControlID="fuExecutiveList">Executive list:</asp:Label>
        <asp:FileUpload ID="fuExecutiveList" runat="server" CssClass="form-control" Required="true" />
    </div>

    <div class="form-group">
        <asp:Label ID="lblPetitionList" runat="server" AssociatedControlID="fuPetitionList">Petition list (minimum 150 students):</asp:Label>
        <asp:FileUpload ID="fuPetitionList" runat="server" CssClass="form-control" Required="true" />
    </div>

    <div class="form-group">
        <asp:Label ID="lblYearPlans" runat="server" AssociatedControlID="fuYearPlans">Year plans:</asp:Label>
        <asp:FileUpload ID="fuYearPlans" runat="server" CssClass="form-control" Required="true" />
    </div>

    <div class="form-group">
        <asp:Label ID="lblBudget" runat="server" AssociatedControlID="fuBudget">Budget:</asp:Label>
        <asp:FileUpload ID="fuBudget" runat="server" CssClass="form-control" Required="true" />
    </div>

    <div class="form-group">
        <asp:Label ID="lblLogo" runat="server" AssociatedControlID="fuLogo">Identifying mark or logo:</asp:Label>
        <asp:FileUpload ID="fuLogo" runat="server" CssClass="form-control" Required="true" />
    </div>

    <div class="form-group">
        <asp:Label ID="lblProofPayment" runat="server" AssociatedControlID="fuProofPayment">Proof of payment of the membership fee:</asp:Label>
        <asp:FileUpload ID="fuProofPayment" runat="server" CssClass="form-control" Required="true" />
    </div>

    <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
</asp:Panel>
</div>
</asp:Content>
