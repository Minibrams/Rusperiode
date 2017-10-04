package Tjanseauktion;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by chrae on 29-08-2017.
 */
public class CLI {
    private ArrayList<Auction> auctions;
    private ArrayList<Team> teams;
    private Writer writer;
    public boolean quit = false;
    private boolean auctionStarted = false;
    private boolean endAuction = false;
    private Auction currentAuction;
    private LogWriter logWriter = new LogWriter();
    private int num_free;
    private int num_pr_gr;

    public CLI(ArrayList<Auction> as, ArrayList<Team> ts, int num_free, int num_per_gr){
        auctions = as;
        teams = ts;
        this.num_free = num_free;
        this.num_pr_gr = num_per_gr;
    }

    public void start(){
        writer = new Writer();
        while(!quit) {
            try {
                new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
            } catch (IOException e){
                e.printStackTrace();
            } catch(InterruptedException e){
                e.printStackTrace();
            }
            writer.writeIntro(auctions.size(), num_free,num_pr_gr);
            writer.writeTeamList(teams);
            writer.writeInputPrompt();
            getCommand();
        }
    }

    private void getCommand(){
        String command = System.console().readLine();

        if(command.startsWith(":"))
            handleAdminCommand(command);
        else
            handleAuctionInput(command);
    }

    private void handleAdminCommand(String command){
        switch (command){
            case ":q":
                quit = true;
                break;
            case  ":quit":
                quit = true;
                break;
            case ":start":
                startAuctions();
                break;
            case ":s":
                startAuctions();
                break;
            case ":break":
                breakAuctions();
                break;
            case ":b":
                breakAuctions();
                break;
            case ":end":
                end();
                break;
            case ":e":
                end();
                break;
            case ":load":
                readLog();
                break;
            case ":l":
                readLog();
                break;
            default:
                writer.writeUnknownCommand();
                getCommand();
                return;
        }
    }

    private void readLog(){
        LogReader reader = new LogReader("log.txt");
        teams = reader.getTeams();
        auctions = reader.getAuctions();
        writer.writeFileLoaded();
        start();
    }

    private void end(){
        if(!auctionStarted){
            writer.writeNoAuction();
            getCommand();
            return;
        }
        if(!currentAuction.hasBid()){
            writer.writeAuctionHasNoBid();
            getCommand();
            return;
        }
        endAuction = true;
        currentAuction.complete();
    }

    private void handleAuctionInput(String input){
        if(!input.matches("^[0-9].*$")){
            writer.writeUnknownCommand();
            getCommand();
            return;
        }
        if(!auctionStarted){
            writer.writeNoAuction();
            getCommand();
            return;
        }

        String[] commands = input.split(" ");

        Team team = null;
        for(Team t : teams){
            if(t.getNum() == Integer.parseInt(commands[0]))
                team = t;
        }

        if(team == null){
            writer.writeTeamNotFound();
            getCommand();
            return;
        }

        int bid;
        try {
            bid = decodeBidString(commands[1]);
        } catch(IndexOutOfBoundsException e){
            writer.writeUnknownCommand();
            getCommand();
            return;
        } catch(NumberFormatException e){
            writer.writeUnknownCommand();
            getCommand();
            return;
        }
        if(!team.canAfford(bid)){
            writer.writeCannotAfford(team.getName());
            getCommand();
            return;
        }
        if(!currentAuction.bid(bid, team.getNum())){
            writer.writeIsNotEnough();
            getCommand();
        }
    }

    private void breakAuctions(){
        if(!auctionStarted){
            writer.writeNoAuction();
            getCommand();
            return;
        }

        auctionStarted = false;
    }

    private void startAuctions(){
        if(auctionStarted){
            writer.writeAuction();
            getCommand();
            return;
        }

        try {
            new BufferedWriter(new FileWriter("log.txt", false)).close();
        } catch(Exception e){
            System.out.println("There was an error creating the log file");
        }

        auctionStarted = true;
        int n = 1;
        for(Auction a : auctions){
            if(!auctionStarted || quit)
                break;
            currentAuction = a;
            if(a.isCompleted()){
                n++;
                saveStatus();
                continue;
            }

            while(!endAuction && !quit && auctionStarted){
                try {
                    new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
                } catch (IOException e){
                    e.printStackTrace();
                } catch(InterruptedException e){
                    e.printStackTrace();
                }
                writer.writeAuctionInfo(currentAuction.getChore(), n, auctions.size());
                if(currentAuction.hasBid()) {
                    for(Team t : teams){
                        if(t.getNum() == currentAuction.getBidder())
                            writer.writeCurrentBid(encodeBidString(currentAuction.getBid()), t.getName());
                    }
                }
                writer.writeTeamList(teams);
                writer.writeInputPrompt();
                getCommand();
            }

            n++;
            if(endAuction) {
                for (Team t : teams) {
                    if (t.getNum() == currentAuction.getBidder())
                        t.buyChore(a.getChore(), currentAuction.getBid());
                }
            }

            endAuction = false;

            saveStatus();
        }

        if(!quit) {
            OutputWriter outputWriter = new OutputWriter("Tjanser.pdf", teams);
            outputWriter.writeOutput();

            writer.writeOutput();
            getCommand();
        }
    }

    private void saveStatus(){
        logWriter.writeStatus(auctions,teams);
    }

    private int decodeBidString(String bid){
        String[] coins = bid.split("\\.");
        return (Integer.parseInt(coins[0])*493)+(Integer.parseInt(coins[1])*29)+Integer.parseInt(coins[2]);
    }

    private String encodeBidString(int bid){
        //ToDo: A high valuta is worth 493 this year. should be changed!
        int high = (int)Math.floor(bid/493);
        //ToDo: A mid valuta is worth 29 this year. should be changed!
        int mid = (int)Math.floor((bid%493)/29);
        int low = (bid%493)%29;

        return high + "." + mid + "." + low;
    }
}
