<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder" %>
<%@page import="java.util.StringTokenizer"%>
<%@page import="org.apache.abdera.Abdera"%>
<%@page import="org.apache.abdera.model.Document"%>
<%@page import="org.apache.abdera.model.Entry"%>
<%@page import="org.apache.abdera.model.Feed"%>
<%@page import="org.apache.abdera.model.Category"%>
<%@page import="org.apache.abdera.model.Link"%>
<%@page import="org.apache.abdera.parser.Parser"%>
<jsp:useBean id="fetchFeed" class="org.atomhopper.atomic.beans.FetchFeed" scope="request"/>
<jsp:setProperty name="fetchFeed" property="*"/> 

<%!
    private static Abdera abdera = null;
    
    private static synchronized Abdera getInstance() {
        if (abdera == null) {
            abdera = new Abdera();
        }
        return abdera;
    }   
%>

<!DOCTYPE html> 
<html>
	<head> 
	<title>-(( Atomic ))-</title> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"> 

	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.css" />
    <link rel="stylesheet" href="css/atomic.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0rc2/jquery.mobile-1.0rc2.min.js"></script>
	<script type="text/javascript" src="scripts/jquery.jfeed.js"></script>	
</head> 
<body>
    <!-- Fetch Page -->
    <div data-role="page" id="fetchpage" data-theme="a">

        <div data-role="header">
            <a href="#fetchpage" id="radiation" name="radiation" data-icon="custom" data-iconpos="notext">Atomic</a>
            <h1>-(( Atomic ))-</h1>
        </div><!-- /header -->

        <div data-role="content">
<%
        Parser parser = getInstance().getParser();
        Document<Feed> doc = null;
        Feed feed = null;        

        try {
            StringBuilder search = new StringBuilder();
            if(fetchFeed.getCategorySearch() != null) {
                StringTokenizer tokenizer = new StringTokenizer(fetchFeed.getCategorySearch(), "|");
                while (tokenizer.hasMoreTokens()) {
                     search.append("+" + tokenizer.nextToken().trim());
                }
            }
            
            String constructedFeedURL = fetchFeed.getFeedSource() +
                    "?limit=" + URLEncoder.encode(String.valueOf(fetchFeed.getSliderValue()),"UTF-8") +
                    "&search=" + URLEncoder.encode(search.toString(),"UTF-8");
%>
            <p>Fetching URL:&nbsp;<%= constructedFeedURL %></p>
<%   
            URL url = new URL(constructedFeedURL);
            doc = parser.parse(url.openStream(), url.toString());
            feed = doc.getRoot();
            
            if (feed.getEntries().isEmpty())
                out.print("<p>No Results</p>");            
%>
            <ul data-role="listview" data-theme="a">
<%            
            for (Entry entry : feed.getEntries()) {
%>
                <li data-role="list-divider">
<%
                if(entry.getPublished() != null) {
                    out.print("Published: " + entry.getPublished());
                } else {
                    out.print("Updated " + entry.getUpdated());
                }
%>
                </li>
                <li>
                    <a href="<%= "fetchresults.jsp#" + entry.getId().toString() %>">
<%
                        if(entry.getAuthor() != null) {
%>
                            <h3><%= entry.getAuthor().getName() %></h3>
<%
                        }
%>
                        <p><strong><%= entry.getTitle() %></strong></p>
                    </a>
                </li>
<%
            }
%>
            </ul>
<%
            } catch (Exception ex) {
                out.print("<p>Error: " + ex.getStackTrace().toString() + "</p>");
            } 
%>
        </div><!-- /content -->

        <div data-role="footer" class="nav-glyphish" data-position="fixed">
            <div data-role="navbar">
                <ul>
                    <li><a data-direction="reverse" data-ajax="false" href="index.jsp#feedpage" data-transition="slide" id="feed" data-icon="custom">Fetch</a></li>
                    <li><a data-direction="reverse" data-ajax="false" href="index.jsp#createpage" data-transition="slide" id="create" data-icon="custom">Create</a></li>
                </ul>
            </div><!-- /navbar -->	
        </div><!-- /footer -->
    </div><!-- /page -->
    
    
    <!-- Render the entry pages -->
<%
    if (feed != null) {
        for (Entry entry : feed.getEntries()) {
%>
            <div data-role="page" id="<%= entry.getId().toString() %>" data-theme="a">

                <div data-role="header">
                    <a href="#fetchpage" id="radiation" name="radiation" data-icon="custom" data-iconpos="notext">Atomic</a>
                    <h1>-(( Atomic ))-</h1>
                </div><!-- /header -->

                <div data-role="content">
<%
                    if(entry.getTitle() != null)
                        out.print("<p>Title: " + entry.getTitle() + "</p>");
                    if(entry.getPublished() != null)
                        out.print("<p>Published: " + entry.getPublished() + "</p>");
                    if(entry.getUpdated() != null)
                        out.print("<p>Updated: " + entry.getUpdated() + "</p>");
                    if(entry.getAuthor() != null) {
                        if(entry.getAuthor().getName() != null)
                            out.print("<p>Author: " + entry.getAuthor().getName() + "</p>");
                        if(entry.getAuthor().getEmail() != null)
                            out.print("<p>Email: " + entry.getAuthor().getEmail() + "</p>");
                    }
                    if(entry.getId() != null)
                        out.print("<p>ID: " + entry.getId() + "</p>");
                    
                    if(entry.getLink("self") != null) {
                        Link selfLink = entry.getLink("self");
                        out.print("<p>Link (Self): " + selfLink.getHref().toString() + "</p>");
                    }
                    
                    // Get the categories
                    int categoryCounter = 1;
                    for (Category category : (List<Category>) entry.getCategories()) {
                        out.print("<p>Category (" + categoryCounter + "): " + category.getTerm() + "</p>");
                        categoryCounter++;
                    }                    
                    if(entry.getContent() != null) {
%>	
                        <label for="contenttextarea">Content:</label>
                        <textarea name="contenttextarea" id="contenttextarea">
<%
                        out.print(entry.getContent());
%>
                        </textarea>
<%          
                    }
%>
                    <fieldset class="ui-grid-b">
                        <div class="ui-block-a">&nbsp;</div>
                        <div class="ui-block-b"><a href="fetchresults.jsp" data-role="button">Back</a></div>
                        <div class="ui-block-c">&nbsp;</div>
                    </fieldset>                     
                </div><!-- /content -->

                <div data-role="footer" class="nav-glyphish" data-position="fixed">
                    <div data-role="navbar">
                        <ul>
                            <li><a data-direction="reverse" data-ajax="false" href="index.jsp#feedpage" data-transition="slide" id="feed" data-icon="custom">Fetch</a></li>
                            <li><a data-direction="reverse" data-ajax="false" href="index.jsp#createpage" data-transition="slide" id="create" data-icon="custom">Create</a></li>
                        </ul>
                    </div><!-- /navbar -->	
                </div><!-- /footer -->
            </div><!-- /page -->
<%
        }
    }
%>    

</body>
</html>
