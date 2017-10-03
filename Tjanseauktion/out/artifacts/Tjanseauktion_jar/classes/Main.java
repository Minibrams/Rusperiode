package Tjanseauktion;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

public class Main {
    static ArrayList<String> chores = new ArrayList<String>();
    static ArrayList<Team> teams = new ArrayList<Team>();
    static ArrayList<Auction> auctions = new ArrayList<Auction>();
    static Random randomGenerator = new Random();
    static int num_chores;

    public static void main(String[] args) {
        int num_free = 0;
        try {
            readFiles(args[0], args[1]);
            num_free = setupSecrets(args[2]);
        } catch(IndexOutOfBoundsException e){
            System.out.println("You did not provide the correct arguments");
        }

        CLI cli = new CLI(auctions,teams,num_free,num_chores);
        cli.start();
    }

    static void readFiles(String choreFile, String teamFile){
        String line;

        // Read chores
        try{
            FileInputStream fis = new FileInputStream(choreFile);
            InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
            BufferedReader br = new BufferedReader(isr);
            int i = 1;
            while ((line = br.readLine()) != null) {
                if(i == 1)
                    chores.add(line.substring(1));
                else
                    chores.add(line);
                i++;
            }
        } catch(IOException e){
            System.out.println("Invalid filename");
        }

        // Read teams
        try {
            InputStream fis = new FileInputStream(teamFile);
            InputStreamReader isr = new InputStreamReader(fis, "UTF-8");
            BufferedReader br = new BufferedReader(isr);
            int i = 1;
            while ((line = br.readLine()) != null) {
                if(i == 1)
                    teams.add(new Team(line.substring(1),i));
                else
                    teams.add(new Team(line,i));
                i++;
            }
        } catch(IOException e){
            System.out.println("Invalid filename");
        }
    }
    static int setupSecrets(String num){
        int num_secret = Integer.parseInt(num);

        for(String s : chores){
            auctions.add(new Auction(s));
        }

        for(int i = 0; i < num_secret; i++){
            int index = randomGenerator.nextInt(auctions.size());
            while(auctions.get(index).isSecret()){
                index = randomGenerator.nextInt(auctions.size());
            }

            auctions.get(index).setSecret();
        }

        // Calculate number of chores per team
        num_chores = (int)Math.ceil((double)chores.size() / teams.size());
        // Calculate number of free chores
        int num_free_chores = (num_chores*teams.size())%chores.size();

        //Insert free chores
        for(int i = 0; i < num_free_chores; i++){
            Auction a = new Auction("Fritjans");
            a.setSecret();
            auctions.add(a);
        }
        Collections.shuffle(auctions);

        return num_free_chores;
    }
}
