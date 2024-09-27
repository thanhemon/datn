<%@ Page Async="true" Title="" Language="C#" MasterPageFile="~/User/Layout/UserLayout.Master" AutoEventWireup="true" CodeBehind="Watch.aspx.cs" Inherits="Web.User.Watch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><% = title_HeadTag %> - Trang xem phim</title>
    <meta charset="UTF-8">
    <meta name="description" content="<% = description_MetaTag %>">
    <meta name="keywords" content="<% = keywords_MetaTag %>">
    <meta name="author" content="">
    <link rel="profile" href="#">

    <link href="<% = ResolveUrl("~/common_assets/video-js/video-js.min.css") %>" rel="stylesheet">
    <script src="<% = ResolveUrl("~/common_assets/video-js/video.js") %>"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <% if (filmInfo != null) { %>
    <div class="page-single">
        <div class="container" style="padding-top: 120px;">
            <div class="col-lg-12 col-md-12 col-sm-12" style="height: 600px;">
                <h1 style="color: white; padding-bottom: 20px;">Bạn đang xem: <% = filmInfo.name %></h1>
             <video id="vid" controls preload="auto" width="100%" height="600">
    <source src='<%= Request.Url.GetLeftPart(UriPartial.Authority) + ResolveUrl(filmInfo.source) %>' type="video/mp4">
    Your browser does not support the video tag.
</video>

            </div>
        </div>
    </div>
    <style type="text/css">
        #vid {
            width: 100% !important;
            height: 600px !important;
        }
    </style>
    <% } %>
  <script type="text/javascript">
      $(document).ready(function () {
          var video = $('#vid')[0];
          var filmSource = "<%= filmInfo.source %>";
        var filmId = "<%= filmInfo.ID %>";

        if (video) {
            video.addEventListener('loadedmetadata', function () {
                var savedTimeKey = 'videoTime_' + filmId;
                var savedTime = sessionStorage.getItem(savedTimeKey);
                if (savedTime !== null && savedTime !== 'undefined' && savedTime !== '') {
                    savedTime = parseFloat(savedTime);
                    if (!isNaN(savedTime) && savedTime > 0 && savedTime < video.duration) {
                        var continueWatching = confirm("Bạn có muốn tiếp tục xem từ vị trí trước đó?");
                        if (continueWatching) {
                            video.currentTime = savedTime;
                            console.log("Continuing from saved time: ", video.currentTime);
                        } else {
                            sessionStorage.removeItem(savedTimeKey);
                            console.log("Cleared saved time.");
                        }
                    } else {
                        console.log("Invalid savedTime: ", savedTime);
                    }
                } else {
                    console.log("No valid saved video time found.");
                }

                $(video).on('timeupdate', function () {
                    var currentTime = video.currentTime;
                    if (!isNaN(currentTime) && currentTime > 0) {
                        sessionStorage.setItem(savedTimeKey, currentTime);
                        console.log("Saving video time to Session Storage: ", currentTime);
                    }
                });

                $(video).on('ended', function () {
                    var userChoice = confirm("Bạn có muốn xem tiếp hay xem từ đầu?");
                    if (userChoice) {
                        video.currentTime = 0;
                        video.play();
                    } else {
                        alert("Video sẽ dừng ở đây.");
                    }
                });

                $(window).on('beforeunload', function (e) {
                    var currentTime = video.currentTime;
                    if (!isNaN(currentTime) && currentTime > 0) {
                        sessionStorage.setItem(savedTimeKey, currentTime);
                        var confirmationMessage = 'Bạn có muốn tiếp tục xem từ vị trí hiện tại không?';
                        (e || window.event).returnValue = confirmationMessage;
                        return confirmationMessage;
                    }
                });
            });

            video.addEventListener('canplay', function () {
                console.log("Video is ready to play.");
            });

            video.addEventListener('error', function (e) {
                var errorMessage = "Failed to load video metadata. Please check the video source.";
                console.error(errorMessage);
                console.error("Error details:", e);
                alert(errorMessage);
            });
        } else {
            console.error("Video element not found or video is not ready.");
        }
    });
  </script>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <% if (hyplnkIncreaseView != null && filmInfo != null) { %>
    <script type="text/javascript">
        setTimeout(function () {
            $(document).ready(function (e) {
                $.post("<% = hyplnkIncreaseView %>", {
                    filmId: "<% = filmInfo.ID %>"
                }, function (data) {
                    console.log(data);
                });
            });
        }, 30000);
    </script>
    <% } %>
</asp:Content>
