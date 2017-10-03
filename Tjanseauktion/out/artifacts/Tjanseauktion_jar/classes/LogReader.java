package Tjanseauktion;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

/**
 * Created by chrae on 02-09-2017.
 */
public class LogReader {
    private ArrayList<Team> teams = new ArrayList<Team>();
    private ArrayList<Auction> auctions = new ArrayList<Auction>();

    public LogReader(String filename){
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filename));
            String line;
            boolean isAuction = false;
            String[] strs;
            while ((line = reader.readLine()) != null) {
                if(line.equals("auctions")){
                    isAuction = true;
                    continue;
                }

                if(!isAuction){
                    strs = line.split(";");

                    Team team = new Team(strs[1],Integer.parseInt(strs[0]));
                    team.setCoins(Integer.parseInt(strs[2]));
                    teams.add(team);
                } else{
                    strs = line.split(";");

                    Auction auction = new Auction(strs[0]);
                    boolean isSecret = Boolean.parseBoolean(strs[3]);
                    if(isSecret)
                        auction.setSecret();

                    boolean isComplete = Boolean.parseBoolean(strs[5]);
                    if(isComplete){
                        auction.bid(Integer.parseInt(strs[1]), Integer.parseInt(strs[2]));
                        auction.complete();

                        for(Team t : teams){
                            if(t.getNum() == Integer.parseInt(strs[2]))
                                t.addChore(strs[0]);
                        }
                    }

                    auctions.add(auction);
                }
            }
        } catch (IOException e){
            System.out.println("Error reading the log file.");
        } catch(IndexOutOfBoundsException e){
            System.out.println("File is incorrect format.");
        }
    }

    public ArrayList<Team> getTeams(){return teams;}
    public ArrayList<Auction> getAuctions(){return auctions;}
}
