package org.atomhopper.atomic.beans;


public class FetchFeed {
    
    private int sliderValue = 25;
    private String categorySearch;
    private String feedSource;

    public String getCategorySearch() {
        return categorySearch;
    }

    public void setCategorySearch(String categorySearch) {
        this.categorySearch = categorySearch;
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
