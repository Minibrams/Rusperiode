package Tjanseauktion;

/**
 * Created by chrae on 28-08-2017.
 */
public class Auction {
    private String chore;
    private int currentBid = 0;
    private int currentBidder = 0;
    private boolean isSecret = false;
    private boolean hasBid = false;
    private boolean completed = false;

    public Auction(String c){
        chore = c;
    }
    public String getChore(){
        if(isSecret)
            return "SECRET - " + chore;
        return chore;
    }
    public void setSecret(){isSecret = true;}
    public int getBidder(){return currentBidder;}
    public int getBid(){return currentBid;}

    public boolean bid(int bid, int bidder){
        if(bid <= currentBid)
            return false;
        currentBid = bid;
        currentBidder = bidder;
        hasBid = true;
        return true;
    }
    public boolean isSecret(){return isSecret;}
    public boolean hasBid(){return hasBid;}
    public void complete(){completed = true;}
    public boolean isCompleted(){return completed;}

    public String toString(){
        String s = "";
        if(isSecret)
            s = "SECRET - ";
        if(currentBidder != 0)
            s += chore + " " + currentBid + " " + currentBidder;
        else
            s += chore + " NOBID";
        return s;
    }

    public String getLogOutput(){
        return chore + ";" + currentBid + ";" + currentBidder + ";" + isSecret + ";" + hasBid + ";" + completed;
    }
}
