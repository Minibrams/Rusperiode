package Tjanseauktion;

import java.util.ArrayList;

/**
 * Created by chrae on 29-08-2017.
 */
public class Writer {
    public void writeIntro(int totalAuctions, int num_free, int num_pr){
        System.out.println("Welcome. There are " + totalAuctions + " auctions, " + num_free + " free chores.\nEach team must have " + num_pr + " chores.\nThe teams are:");
    }
    public void writeCurrentBid(String bid, String bidder){
        System.out.println("Current bid: " + bid);
        System.out.println("Current bidder: " + bidder);
    }
    public void writeAuctionInfo(String name, int auctionNum, int totalAuctions){
        System.out.println(name);
        System.out.println("Auction " + auctionNum + "/" + totalAuctions);
    }
    public void writeTeamList(ArrayList<Team> teams){
        String leftAlignFormat = "| %-3d | %-28s | %-8s | %-6d |%n";

        System.out.format("+-----+------------------------------+----------+--------+%n");
        System.out.format("| Num | Name                         | Coins    | Chores |%n");
        System.out.format("+-----+------------------------------+----------+--------+%n");
        for (Team t : teams) {
            System.out.format(leftAlignFormat, t.getNum(), t.getName(), t.getCoinString(), t.getChores().size());
        }
        System.out.format("+-----+------------------------------+----------+--------+%n");
    }
    public void writeInputPrompt(){
        System.out.println("Write command: ");
    }
    public void writeUnknownCommand(){
        System.out.println("Unknown command. Try again:");
    }
    public void writeNoAuction(){
        System.out.println("No auction has started! Try again:");
    }
    public void writeAuction(){
        System.out.println("Auctions has already started! Try again:");
    }
    public void writeTeamNotFound(){
        System.out.println("Team not found. Please try again:");
    }
    public void writeCannotAfford(String name){
        System.out.println(name + " cannot afford this! Try again:");
    }
    public void writeIsNotEnough(){
        System.out.println("Current bid is not enough. Try again:");
    }
    public void writeAuctionHasNoBid(){
        System.out.println("Current auction has no bid. Try again:");
    }
    public void writeFileLoaded(){
        System.out.println("Logfile has successfully loaded. Input command:");
    }
    public void writeOutput(){
        System.out.println("Output file has been succesfully written. Input command:");
    }
}
