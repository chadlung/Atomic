package org.atomhopper.atomic.beans;


public class FetchFeed {
    
    private int sliderValue = 25;
    private String categorySearch;
    private String feedDirection = "backward";
    private String feedSource;

    public String getCategorySearch() {
        return categorySearch;
    }

    public void setCategorySearch(String categorySearch) {
        this.categorySearch = categorySearch;
    }

    public String getFeedDirection() {
        return feedDirection;
    }

    public void setFeedDirection(String feedDirection) {
        this.feedDirection = feedDirection;
    }

    public int getSliderValue() {
        return sliderValue;
    }

    public void setSliderValue(int sliderValue) {
        this.sliderValue = sliderValue;
    }
    
    public String getFeedSource() {
        return feedSource;
    }

    public void setFeedSource(String feedSource) {
        this.feedSource = feedSource;
    }    
}
