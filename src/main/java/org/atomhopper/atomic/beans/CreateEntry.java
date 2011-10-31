package org.atomhopper.atomic.beans;

public class CreateEntry {

    private String atomTitle;
    private String atomPublished;
    private String atomSummary;
    private String atomContent;
    private String atomCategories;
    private String atomLink;
    private String atomAuthorName = "";
    private String atomAuthorEmail = "";
    private String atomAuthorUrl = "";
    private String atomContributorName = "";
    private String atomContributorEmail = "";
    private String atomContributorUrl = "";
    private String atomSourceTitle = "";
    private String atomSourceSubTitle = "";
    private String atomSourceLink = "";
    private String atomSourceCopyright = "";
    private String createFeedSource = "";

    public String getAtomAuthorEmail() {
        return atomAuthorEmail;
    }

    public void setAtomAuthorEmail(String atomAuthorEmail) {
        this.atomAuthorEmail = atomAuthorEmail;
    }

    public String getAtomAuthorName() {
        return atomAuthorName;
    }

    public void setAtomAuthorName(String atomAuthorName) {
        this.atomAuthorName = atomAuthorName;
    }

    public String getAtomAuthorUrl() {
        return atomAuthorUrl;
    }

    public void setAtomAuthorUrl(String atomAuthorUrl) {
        this.atomAuthorUrl = atomAuthorUrl;
    }

    public String getAtomContent() {
        return atomContent;
    }
    
    public String getAtomCategories() {
        return atomCategories;
    }

    public void setAtomCategories(String atomCategories) {
        this.atomCategories = atomCategories;
    }    

    public void setAtomContent(String atomContent) {
        this.atomContent = atomContent;
    }

    public String getAtomContributorEmail() {
        return atomContributorEmail;
    }

    public void setAtomContributorEmail(String atomContributorEmail) {
        this.atomContributorEmail = atomContributorEmail;
    }

    public String getAtomContributorName() {
        return atomContributorName;
    }

    public void setAtomContributorName(String atomContributorName) {
        this.atomContributorName = atomContributorName;
    }

    public String getAtomContributorUrl() {
        return atomContributorUrl;
    }

    public void setAtomContributorUrl(String atomContributorUrl) {
        this.atomContributorUrl = atomContributorUrl;
    }

    public String getAtomLink() {
        return atomLink;
    }

    public void setAtomLink(String atomLink) {
        this.atomLink = atomLink;
    }

    public String getAtomPublished() {
        return atomPublished;
    }

    public void setAtomPublished(String atomPublished) {
        this.atomPublished = atomPublished;
    }

    public String getAtomSourceCopyright() {
        return atomSourceCopyright;
    }

    public void setAtomSourceCopyright(String atomSourceCopyright) {
        this.atomSourceCopyright = atomSourceCopyright;
    }

    public String getAtomSourceLink() {
        return atomSourceLink;
    }

    public void setAtomSourceLink(String atomSourceLink) {
        this.atomSourceLink = atomSourceLink;
    }

    public String getAtomSourceSubTitle() {
        return atomSourceSubTitle;
    }

    public void setAtomSourceSubTitle(String atomSourceSubTitle) {
        this.atomSourceSubTitle = atomSourceSubTitle;
    }

    public String getAtomSourceTitle() {
        return atomSourceTitle;
    }

    public void setAtomSourceTitle(String atomSourceTitle) {
        this.atomSourceTitle = atomSourceTitle;
    }

    public String getAtomSummary() {
        return atomSummary;
    }

    public void setAtomSummary(String atomSummary) {
        this.atomSummary = atomSummary;
    }

    public String getAtomTitle() {
        return atomTitle;
    }

    public void setAtomTitle(String atomTitle) {
        this.atomTitle = atomTitle;
    }

    public String getCreateFeedSource() {
        return createFeedSource;
    }

    public void setCreateFeedSource(String createFeedSource) {
        this.createFeedSource = createFeedSource;
    }
}
