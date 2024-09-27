<%@ Page Async="true" Language="C#" MasterPageFile="~/User/Layout/UserLayout.Master" AutoEventWireup="true" CodeBehind="SearchByTag.aspx.cs" Inherits="Web.User.SearchByTag" %>
<%@ Import Namespace="Data.DTO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Trang xem theo thẻ tag</title>
    <meta charset="UTF-8">
    <meta name="description" content="trang phim theo thể loại">
    <meta name="keywords" content="phim theo thể loại">
    <meta name="author" content="">
    <link rel="profile" href="#">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="hero common-hero">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="hero-ct">
                        <h1>Phim theo thẻ tag</h1>
                        <%--<ul class="breadcumb">
                            <li class="active"><a href="#">Home</a></li>
                            <li><span class="ion-ios-arrow-right"></span>movie listing</li>
                        </ul>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="page-single">
        <div class="container">
            <div class="row ipad-width">
             <% if (filmInfos != null)
   { %>
<div class="col-md-12 col-sm-12 col-xs-12">
    <div class="topbar-filter">
        <p>Tìm thấy: <span><%= filmInfos.Count %></span> kết quả</p>
    </div>
    <div class="flex-wrap-movielist">
        <% foreach (FilmInfo filmInfo in filmInfos)
           {%>
        <div class="movie-item-style-2 movie-item-style-1">
            <img src="/FileUpload/Images/<% = filmInfo.thumbnail %>" alt="<% = filmInfo.name %>">
            <div class="hvr-inner">
                <a href="<%= filmInfo.url %>">Xem chi tiết <i class="ion-android-arrow-dropright"></i></a>
            </div>
            <div class="mv-item-infor">
                <h6><a href="<%= filmInfo.url %>"><%= filmInfo.name %></a></h6>
                <p class="rate"><i class="ion-android-star"></i><span><%= string.Format("{0:0.00}", filmInfo.scoreRating) %></span> /10</p>
            </div>
        </div>
        <% } %>
    </div>
</div>
<% } %>

            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
</asp:Content>
