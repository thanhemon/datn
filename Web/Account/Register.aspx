﻿<%@ Page Async="true" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Web.Account.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng ký tài khoản</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="<% = ResolveUrl("~/account_assets/images/favicon.png") %>" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/account_assets/css/register.css") %>">

</head>
<body>
    <form id="frmRegister" method="post" runat="server">
        <div class="register-form">
            <div class="register-form-title">
                <h3>Đăng ký tài khoản</h3>
                <p>Hãy đăng ký để thưởng thức những tác phẩm điện ảnh hay, chất lượng nhất</p>
                <hr />
            </div>
            <div class="register-form-data">
                <div class="register-form-group" style="padding-left: 200px;">
                    <h4>Thông tin cơ bản</h4>
                    <p>Tên người dùng</p>
                    <asp:TextBox ID="txtUsername" Placeholder="Nhập vào tên người dùng" Text="" TextMode="SingleLine" runat="server"></asp:TextBox>
                    <div class="show-error">
                        <asp:CustomValidator ID="cvUsername" runat="server"></asp:CustomValidator>
                    </div>
                    <p>Địa chỉ Email</p>
                    <asp:TextBox ID="txtEmail" Placeholder="Nhập vào địa chỉ Email" Text="" TextMode="Email" runat="server"></asp:TextBox>
                    <div class="show-error">
                        <asp:CustomValidator ID="cvEmail" runat="server"></asp:CustomValidator>
                    </div>
                    <p>Số điện thoại</p>
                    <asp:TextBox ID="txtPhoneNumber" Placeholder="Nhập vào số điện thoại" Text="" TextMode="SingleLine" runat="server"></asp:TextBox>
                    <div class="show-error">
                        <asp:CustomValidator ID="cvPhoneNumber" runat="server"></asp:CustomValidator>
                    </div>
                    <p>Mật khẩu</p>
                    <asp:TextBox ID="txtPassword" Placeholder="Nhập vào mật khẩu" Text="" TextMode="Password" runat="server"></asp:TextBox>
                    <div class="show-error">
                        <asp:CustomValidator ID="cvPassword" runat="server"></asp:CustomValidator>
                    </div>
                    <p>Xác nhận mật khẩu</p>
                    <asp:TextBox ID="txtRePassword" Placeholder="Nhập vào xác nhận mật khẩu" Text="" TextMode="Password" runat="server"></asp:TextBox>
                    <div class="show-error">
                        <asp:CompareValidator ID="cmpRePassword" runat="server"></asp:CompareValidator>
                    </div>
                </div>
               
            </div>
            <div class="register-form-submit">
                <asp:Button ID="btnSubmit" CssClass="button button-red button-register" runat="server" Text="Đăng ký" />
            </div>
        </div>
    </form>
    <% if (enableShowResult)
        { %>
    <script type="text/javascript">
        var stateDetail = "<% = stateDetail %>";
        setTimeout(function () {
            alert(stateDetail);
        }, 1500);
    </script>
    <%} %>
</body>
</html>
