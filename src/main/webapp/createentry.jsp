<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="org.apache.abdera.Abdera"%>
<%@page import="org.apache.abdera.factory.Factory"%>
<%@page import="org.apache.abdera.model.Entry"%>
<%@page import="org.apache.abdera.model.Person"%>
<%@page import="org.apache.abdera.model.Source"%>
<%@page import="org.apache.abdera.model.Category"%>
<%@page import="org.apache.abdera.protocol.client.AbderaClient"%>
<%@page import="org.apache.abdera.protocol.client.RequestOptions"%>
<%@page import="org.apache.abdera.protocol.client.ClientResponse"%>
<jsp:useBean id="createEntry" class="org.atomhopper.atomic.beans.CreateEntry" scope="session"/>
<jsp:setProperty name="createEntry" property="*"/>

<%
    Abdera abdera = new Abdera();
    AbderaClient abderaClient = new AbderaClient(abdera);
    Factory factory = abdera.getFactory();

    Entry entry = factory.newEntry();

    if(createEntry.getAtomTitle() != null)
        entry.setTitle(createEntry.getAtomTitle());

    if(createEntry.getAtomPublished() != null)
        entry.setPublished(new Date(createEntry.getAtomPublished()));

    if(createEntry.getAtomSummary() != null)
        entry.setSummary(createEntry.getAtomSummary());

    if(createEntry.getAtomContent() != null)
        entry.setContent(createEntry.getAtomContent());

    if(createEntry.getAtomLink() != null)
        entry.addLink(createEntry.getAtomLink());

    Person author = abdera.getFactory().newAuthor();
    author.setName(createEntry.getAtomAuthorName());
    author.setEmail(createEntry.getAtomAuthorEmail());
    author.setUri(createEntry.getAtomAuthorUrl());
    entry.addAuthor(author);

    Person contributor = abdera.getFactory().newContributor();
    contributor.setName(createEntry.getAtomContributorName());
    contributor.setEmail(createEntry.getAtomContributorEmail());
    contributor.setUri(createEntry.getAtomContributorUrl());
    entry.addContributor(contributor);

    Source source = abdera.getFactory().newSource();
    source.setTitle(createEntry.getAtomSourceTitle());
    source.setSubtitle(createEntry.getAtomSourceSubTitle());
    source.addLink(createEntry.getAtomSourceLink());
    source.setRights(createEntry.getAtomSourceCopyright());
    entry.setSource(source);
    
    if(createEntry.getAtomCategories() != null) {
        StringTokenizer tokenizer = new StringTokenizer(createEntry.getAtomCategories(), "|");
        while (tokenizer.hasMoreTokens()) {
            Category category = abdera.getFactory().newCategory();
            category.setTerm(tokenizer.nextToken().trim());
            entry.addCategory(category);
        }
    }

    RequestOptions opts = new RequestOptions();
    opts.setContentType("application/atom+xml;type=entry");

    ClientResponse resp = abderaClient.post(createEntry.getCreateFeedSource(), entry, opts);
    if (resp.getStatus() == 201) {
        out.print("SUCCESS");
    } else {
      out.print(resp.getStatusText());
    }
%>