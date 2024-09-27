﻿<%@ Page Async="true" Title="" Language="C#" MasterPageFile="~/User/Layout/UserLayout.Master" AutoEventWireup="true" CodeBehind="FilmDetail.aspx.cs" Inherits="Web.User.FilmDetail" %>

<%@ Import Namespace="Data.DTO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><% = title_HeadTag %> - Trang chi tiết</title>
    <meta charset="UTF-8">
    <meta name="description" content="<% = description_MetaTag %>">
    <meta name="keywords" content="<% = keywords_MetaTag %>">
    <meta name="author" content="">
    <link rel="profile" href="#">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="hero mv-single-hero">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                </div>
            </div>
        </div>
    </div>
    <% if (filmInfo != null)
        { %>
    <div class="page-single movie-single movie_single">
        <div class="container">
            <div class="row ipad-width2">
                <div class="col-md-4 col-sm-12 col-xs-12">
                    <div class="movie-img sticky-sb">
                        <img src="<% = filmInfo.thumbnail %>" alt="">
                        <div class="movie-btn">
                            <div class="btn-transform transform-vertical red">
                                <div><a href="#" class="item item-1 redbtn"><i class="ion-play"></i>Xem phim</a></div>
                                <div><a href="<% = filmInfo.url %>" class="item item-2 redbtn"><i class="ion-play"></i>Xem ngay</a></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 col-sm-12 col-xs-12">
                    <div class="movie-single-ct main-content">
                        <h1 class="bd-hd"><% = filmInfo.name %><span><% = filmInfo.releaseDate %></span></h1>
                        <div class="social-btn">
                            <% if (userId != null)
                                { %>
                            <a href="#" class="parent-btn" onclick="upvote();"><i class="ion-heart"></i>Thích</a>
                            <a href="#" class="parent-btn" onclick="downvote();"><i class="ion-heart"></i>Không thích</a>
                            <%} %>
                            <div class="hover-bnt">
                                <a href="#" class="parent-btn"><i class="ion-android-share-alt"></i>Chia sẻ</a>
                                <div class="hvr-item">
                                    <a href="#" class="hvr-grow"><i class="ion-social-facebook"></i></a>
                                    <a href="#" class="hvr-grow"><i class="ion-social-twitter"></i></a>
                                    <a href="#" class="hvr-grow"><i class="ion-social-googleplus"></i></a>
                                    <a href="#" class="hvr-grow"><i class="ion-social-youtube"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="movie-rate">
                            <div class="rate">
                                <i class="ion-android-star"></i>
                                <p>
                                    <span><% = string.Format("{0:0.00}", filmInfo.scoreRating) %></span> /10<br>
                                    <span class="rv"><% = filmInfo.views %> lượt xem</span>
                                </p>
                            </div>
                            <div class="rate-star">
                                <p>Đánh giá: </p>
                                <% for (int i = 0; i < filmInfo.starRating; i++)
                                    { %>
                                <i class="ion-ios-star"></i>
                                <% } %>
                                <% for (int i = 0; i < 10 - filmInfo.starRating; i++)
                                    { %>
                                <i class="ion-ios-star-outline"></i>
                                <%} %>
                            </div>
                        </div>
                        <div class="movie-tabs">
                            <div class="tabs">
                                <ul class="tab-links tabs-mv">
                                    <li class="active"><a href="#overview">Tổng quan</a></li>
                                   <!-- <li><a href="#moviesrelated">Phim liên quan</a></li> -->
                                </ul>
                                <div class="tab-content">
                                    <div id="overview" class="tab active">
                                        <div class="row">
                                            <div class="col-md-8 col-sm-12 col-xs-12">
                                                <p class="text-justif"><% = filmInfo.description %></p>
                                                <div class="title-hd-sm">
                                                    <h4>Đạo diễn</h4>
                                                    <a href="#" class="time">Xem chi tiết<i class="ion-ios-arrow-right"></i></a>
                                                </div>
                                                <div class="mvcast-item">
                                                    <% foreach (DirectorInfo directorInfo in filmInfo.Directors)
                                                        { %>
                                                    <div class="cast-it">
                                                        <div class="cast-left">
                                                            <%--<img src="images/uploads/cast1.jpg" alt="">--%>
                                                            <a href="<%= directorInfo.description %>"><% = directorInfo.name %></a>
                                                        </div>
                                                    </div>
                                                    <%} %>
                                                </div>
                                                <div class="title-hd-sm">
                                                    <h4>Diễn viên</h4>
                                                    <a href="#" class="time">Xem chi tiết<i class="ion-ios-arrow-right"></i></a>
                                                </div>
                                                <div class="mvcast-item">
                                                    <% foreach (CastInfo castInfo in filmInfo.Casts)
                                                        { %>
                                                    <div class="cast-it">
                                                        <div class="cast-left">
                                                            <%--<img src="images/uploads/cast1.jpg" alt="">--%>
                                                            <a href="<%= castInfo.description %>"><% = castInfo.name %></a>
                                                        </div>
                                                    </div>
                                                    <%} %>
                                                </div>
                                            </div>
                                            <div class="col-md-4 col-xs-12 col-sm-12">
                                                <div class="sb-it">
                                                    <h6>Thể loại:</h6>
                                                    <p>
                                                        <% foreach (CategoryInfo categoryInfo in filmInfo.Categories)
                                                            {
                                                        %>
                                                        <a class="search-cate" data-category="<%= categoryInfo.name %>" href="#"><%= categoryInfo.name %></a>,   
                                                        <%} %>
                                                    </p>
                                                </div>
                                                <div class="sb-it">
                                                    <h6>Ngày phát hành:</h6>
                                                    <p>
                                                        <% = filmInfo.releaseDate %>
                                                    </p>
                                                </div>
                                                <div class="sb-it">
                                                    <h6>Công ty sản xuất:</h6>
                                                    <p>
                                                        <% = filmInfo.productionCompany %>
                                                    </p>
                                                </div>
                                                <div class="sb-it">
                                                    <h6>Ngôn ngữ:</h6>
                                                    <p>
                                                        <% = filmInfo.Language.name %>
                                                    </p>
                                                </div>
                                                <div class="sb-it">
                                                    <h6>Quốc gia:</h6>
                                                    <p>
                                                        <% = filmInfo.Country.name %>
                                                    </p>
                                                </div>
                                              <div class="sb-it">
    <h6>Thẻ tag:</h6>
    <p class="tags">
        <% foreach (TagInfo tagInfo in filmInfo.Tags)
           { %>
           <span class="time">
               <a href='<%= ResolveUrl(string.Format("~/films-by-tag/{0}", tagInfo.ID)) %>'>
                   <%= tagInfo.name %>
               </a>
           </span>,
        <% } %>
    </p>
</div>

                                                <div class="ads">
                                                    <img src="<% = ResolveUrl("~/user_assets/images/uploads/banner_img.jpg") %>" alt="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div id="moviesrelated" class="tab">
                                        <div class="row">
                                            <h3>Related Movies To</h3>
                                            <h2>Skyfall: Quantum of Spectre</h2>
                                            <div class="topbar-filter">
                                                <p>Found <span>12 movies</span> in total</p>
                                                <label>Sort by:</label>
                                                <select>
                                                    <option value="popularity">Popularity Descending</option>
                                                    <option value="popularity">Popularity Ascending</option>
                                                    <option value="rating">Rating Descending</option>
                                                    <option value="rating">Rating Ascending</option>
                                                    <option value="date">Release date Descending</option>
                                                    <option value="date">Release date Ascending</option>
                                                </select>
                                            </div>
                                            <div class="movie-item-style-2">
                                                <img src="images/uploads/mv1.jpg" alt="">
                                                <div class="mv-item-infor">
                                                    <h6><a href="#">oblivion <span>(2012)</span></a></h6>
                                                    <p class="rate"><i class="ion-android-star"></i><span>8.1</span> /10</p>
                                                    <p class="describe">Earth's mightiest heroes must come together and learn to fight as a team if they are to stop the mischievous Loki and his alien army from enslaving humanity...</p>
                                                    <p class="run-time">Run Time: 2h21’    .     <span>MMPA: PG-13 </span>.     <span>Release: 1 May 2015</span></p>
                                                    <p>Director: <a href="#">Joss Whedon</a></p>
                                                    <p>Stars: <a href="#">Robert Downey Jr.,</a> <a href="#">Chris Evans,</a> <a href="#">Chris Hemsworth</a></p>
                                                </div>
                                            </div>
                                            <div class="topbar-filter">
                                                <label>Movies per page:</label>
                                                <select style="width: 100px">
                                                    <option value="range">5 Movies</option>
                                                    <option value="saab">10 Movies</option>
                                                </select>
                                                <div class="pagination2">
                                                    <span>Page 1 of 2:</span>
                                                    <a class="active" href="#">1</a>
                                                    <a href="#">2</a>
                                                    <a href="#"><i class="ion-arrow-right-b"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%} %>
   <script type="text/javascript">
       $(document).ready(function () {
           $(".search-cate").click(function (e) {
               e.preventDefault();
               var category = $(this).data("category");
               window.location.href = "<%= hyplnkSearch %>?input=" + category;
        });
    });
</script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <% if (filmInfo != null && hyplnkUpvote != null && hyplnkDownvote != null && userId != null)
        { %>
   <script type="text/javascript">
       function upvote() {
           $.post("<%= hyplnkUpvote %>", {
            filmId: "<%= filmInfo.ID %>",
            userId: "<%= userId %>"
        })
               .done(function (data) {
                   alert(data); // Display the response from the server
               })
               .fail(function () {
                   alert("Có lỗi xảy ra khi bạn cố gắng thích phim này.");
               });
       }

       function downvote() {
           $.post("<%= hyplnkDownvote %>", {
            filmId: "<%= filmInfo.ID %>",
            userId: "<%= userId %>"
        })
               .done(function (data) {
                   alert(data); // Display the response from the server
               })
               .fail(function () {
                   alert("Có lỗi xảy ra khi bạn cố gắng không thích phim này.");
               });
       }
</script>
    <% } %>
</asp:Content>
