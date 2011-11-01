<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.StringTokenizer"%>
<!DOCTYPE html>
<html>
    <head>
        <title>-(( Atomic ))-</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.css" />
        <link rel="stylesheet" href="css/atomic.css" />
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
        <script type="text/javascript" src="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.js"></script>
        <script type="text/javascript" src="scripts/jquery.jfeed.js"></script>


        <script type="text/javascript">
            function resetTextFields()
            {
                $("#atomTitle").val("");
                $("#atomPublished").val("");
                $("#atomSummary").val("");
                $("#atomContent").val("");
                $("#atomLink").val("");
                $("#atomCategories").val("");
                $("#atomAuthorName").val("");
                $("#atomAuthorEmail").val("");
                $("#atomAuthorUrl").val("");
                $("#atomContributorName").val("");
                $("#atomContributorEmail").val("");
                $("#atomContributorUrl").val("");
                $("#atomSourceTitle").val("");
                $("#atomSourceSubTitle").val("");
                $("#atomSourceLink").val("");
                $("#atomSourceCopyright").val("");
            }

            function onSuccess(data, status)
            {
                // Notify the user the new ATOM entry was saved
                $("#notification").removeClass();                 
                $("#notification").fadeIn(2000);
                data = $.trim(data);
                if(data == "SUCCESS")
                {
                    resetTextFields();                    
                    $("#notification").addClass("success");
                    $("#notification").text("The ATOM entry was saved");
                }
                else
                {
                    $("#notification").addClass("error");
                    $("#notification").text(data);
                }
                $("#notification").fadeOut(5000);               
            }

            function onError(data, status)
            {
                $("#notification").addClass("error");
                $("#notification").text(data);
            }

            $(document).ready(function() {
                $("#createAtomEntry").click(function(){

                    var formData = $("#formCreateAtomEntry").serialize();

                    $.ajax({
                        type: "POST",
                        url: "createentry.jsp",
                        cache: false,
                        data: formData,
                        success: onSuccess,
                        error: onError
                    });

                    return false;
                });
            });
        </script>
    </head>
    <body>

<%
            String availFeeds = getServletContext().getInitParameter("feeds");

            StringBuilder optionValues = new StringBuilder();

            StringTokenizer tokenizer = new StringTokenizer(availFeeds, "|");
            while (tokenizer.hasMoreTokens()) {
                String tmp = tokenizer.nextToken().trim();
                 optionValues.append("<option value='" + tmp + "'>" + tmp + "</option>");
            }
%>

        <!-- Fetch Page -->
        <div data-role="page" id="fetchpage" data-theme="a">

            <div data-role="header">
                <a href="#fetchpage" id="radiation" name="radiation" data-icon="custom" data-iconpos="notext">Atomic</a>
                <h1>-(( Atomic ))-</h1>
            </div><!-- /header -->
            <div data-role="content">
                <form action="fetchresults.jsp" method="post" data-ajax="false">
                    <div data-role="fieldcontain">
                        <label for="feedSource" class="select">Choose Feed:</label>
                        <select name="feedSource" id="feedSource" data-native-menu="false">
                            <%= optionValues.toString() %>
                        </select>
                    </div>

                    <div data-role="fieldcontain">
                        <label for="sliderValue">Limit:</label>
                        <input type="range" name="sliderValue" id="sliderValue" value="25" min="1" max="100"  />
                    </div>

                    <div data-role="fieldcontain">
                        <label for="categorySearch">Category Search:</label>
                        <input type="search" name="categorySearch" id="categorySearch" value="" />
                    </div>

                    <span><span style="text-decoration: underline;">Note:</span> Categories can be split with the pipe | character.  For multiple categories try this: MyCat1 | MyCat2</span>

                    <fieldset class="ui-grid-b">
                        <div class="ui-block-a">&nbsp;</div>
                        <div class="ui-block-b"><button type="submit" data-theme="b">Submit</button></div>
                        <div class="ui-block-c">&nbsp;</div>
                    </fieldset>
                </form>
            </div><!-- /content -->

            <div data-role="footer" class="nav-glyphish" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#feedpage" data-transition="slide" id="feed" class="ui-btn-active ui-state-persist" data-icon="custom">Fetch</a></li>
                        <li><a href="#createpage" data-transition="slide" id="create" data-icon="custom">Create</a></li>
                    </ul>
                </div><!-- /navbar -->
            </div><!-- /footer -->
        </div><!-- /page -->

        <!-- Create Page -->
        <div data-role="page" id="createpage" data-theme="a">

            <div data-role="header">
                <a href="#fetchpage" id="radiation" name="radiation" data-icon="custom" data-iconpos="notext">Atomic</a>
                <h1>-(( Atomic ))-</h1>
            </div><!-- /header -->

            <div data-role="content">
                <form id="formCreateAtomEntry">

                    <div data-role="fieldcontain">
                        <label for="createFeedSource" class="select">Choose Feed:</label>
                        <select name="createFeedSource" id="createFeedSource" data-native-menu="false">
                            <%= optionValues.toString() %>
                        </select>
                    </div>

                    <div data-role="fieldcontain">
                        <label for="atomTitle">Title:</label>
                        <input type="text" name="atomTitle" id="atomTitle" value=""  />
                    </div>
                    <div data-role="fieldcontain">
                        <label for="atomPublished">Published:</label>
                        <input type="date" name="atomPublished" id="atomPublished" value=""  />
                    </div>
                    <div data-role="fieldcontain">
                        <label for="atomSummary">Summary:</label>
                        <input type="text" name="atomSummary" id="atomSummary" value=""  />
                    </div>
                    <div data-role="fieldcontain">
                        <label for="atomContent">Content:</label>
                        <textarea name="atomContent" id="atomContent"></textarea>
                    </div>
                    <div data-role="fieldcontain">
                        <label for="atomLink">Link:</label>
                        <input type="url" name="atomLink" id="atomLink" value=""  />
                    </div>
                    <div data-role="fieldcontain">
                        <label for="atomCategories">Categories:</label>
                        <input type="text" name="atomCategories" id="atomCategories" value="" />
                    </div>
                        
                    <span><span style="text-decoration: underline;">Note:</span> Categories can be split with the pipe | character.  For multiple categories try this: MyCat1 | MyCat2</span>

                    <div data-role="collapsible-set">
                        <div data-role="collapsible" data-collapsed="true">
                            <h3>Author</h3>
                            <div data-role="fieldcontain">
                                <label for="atomAuthorName">Name:</label>
                                <input type="text" name="atomAuthorName" id="atomAuthorName" value=""  />
                            </div>
                            <div data-role="fieldcontain">
                                <label for="atomAuthorEmail">Email:</label>
                                <input type="email" name="atomAuthorEmail" id="atomAuthorEmail" value=""  />
                            </div>
                            <div data-role="fieldcontain">
                                <label for="atomAuthorUrl">Url:</label>
                                <input type="text" name="atomAuthorUrl" id="atomAuthorUrl" value=""  />
                            </div>
                        </div>

                        <div data-role="collapsible" data-collapsed="true">
                            <h3>Contributor</h3>
                            <div data-role="fieldcontain">
                                <label for="atomContributorName">Name:</label>
                                <input type="text" name="atomContributorName" id="atomContributorName" value=""  />
                            </div>
                            <div data-role="fieldcontain">
                                <label for="atomContributorEmail">Email:</label>
                                <input type="email" name="atomContributorEmail" id="atomContributorEmail" value=""  />
                            </div>
                            <div data-role="fieldcontain">
                                <label for="atomContributorUrl">Url:</label>
                                <input type="text" name="atomContributorUrl" id="atomContributorUrl" value=""  />
                            </div>
                        </div>

                        <div data-role="collapsible" data-collapsed="true">
                            <h3>Source</h3>
                            <div data-role="fieldcontain">
                                <label for="atomSourceTitle">Title:</label>
                                <input type="text" name="atomSourceTitle" id="atomSourceTitle" value=""  />
                            </div>
                            <div data-role="fieldcontain">
                                <label for="atomSourceSubTitle">Subtitle:</label>
                                <input type="email" name="atomSourceSubTitle" id="atomSourceSubTitle" value=""  />
                            </div>
                            <div data-role="fieldcontain">
                                <label for="atomSourceLink">Link:</label>
                                <input type="text" name="atomSourceLink" id="atomSourceLink" value=""  />
                            </div>
                            <div data-role="fieldcontain">
                                <label for="atomSourceCopyright">Copyright:</label>
                                <input type="text" name="atomSourceCopyright" id="atomSourceCopyright" value=""  />
                            </div>
                        </div>
                    </div>

                    <h3 id="notification"></h3>

                    <fieldset class="ui-grid-b">
                        <div class="ui-block-a">&nbsp;</div>
                        <div class="ui-block-b"><button type="submit" data-theme="b" id="createAtomEntry" name="createAtomEntry">Submit</button></div>
                        <div class="ui-block-c">&nbsp;</div>
                    </fieldset>
                </form>

            </div><!-- /content -->

            <div data-role="footer" class="nav-glyphish" data-position="fixed">
                <div data-role="navbar">
                    <ul>
                        <li><a href="#fetchpage" data-direction="reverse" data-transition="slide" id="feed" data-icon="custom">Fetch</a></li>
                        <li><a href="#createpage" data-transition="slide" class="ui-btn-active ui-state-persist" id="create" data-icon="custom">Create</a></li>
                    </ul>
                </div><!-- /navbar -->
            </div><!-- /footer -->
        </div><!-- /page -->

    </body>
</html>