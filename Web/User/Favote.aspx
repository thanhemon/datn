<%@ Page Async="true" Language="C#" MasterPageFile="~/User/Layout/UserLayout.Master" AutoEventWireup="true"  CodeBehind="Favote.aspx.cs" Inherits="Web.User.Favote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Phim bạn đã thích</title>
    <meta charset="UTF-8">
    <meta name="description" content="lịch sử thích phim">
    <meta name="keywords" content="phim đã thích, lịch sử xem phim">
    <meta name="author" content="">
    <link rel="profile" href="#">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="hero common-hero">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="hero-ct">
                        <h1>Phim bạn đã thích</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="page-single">
        <div class="container">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <h5 id="txtState" style="color: #ffffff;" runat="server"></h5>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12">
                <asp:DataList ID="dlWatchedList"  OnItemCommand="dlWatchedList_ItemCommand" runat="server">
                    <ItemTemplate>
                        <table>
                            <tr>
                                <td>
                                  <asp:Image 
    ID="Image2" 
    runat="server" 
    Width="185" 
    Height="284" 
    ImageUrl='<%# string.IsNullOrEmpty(Eval("thumbnail") as string) ? "/FileUpload/Images/Default/default.png" : "/FileUpload/Images/" + Eval("thumbnail") %>' 
/>
                                <td>
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Label3" runat="server" ForeColor="White" Text='<%# Eval("name") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" ForeColor="White" Text='<%# Eval("createAt") %>'></asp:Label>
                                            </td>
                                            <td>
                                                 <asp:HiddenField ID="hfFilmId" runat="server" Value='<%# Eval("ID") %>' />
                        <asp:Button ID="btnDelete" runat="server" Text="Xóa phim yêu thích" CommandName="DeleteFilm" CommandArgument='<%# Eval("ID") %>' />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
</asp:Content>
