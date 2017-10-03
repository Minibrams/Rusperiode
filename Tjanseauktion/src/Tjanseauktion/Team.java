package Tjanseauktion;

import java.util.ArrayList;

/**
 * Created by chrae on 28-08-2017.
 */
public class Team {
    private int number;
    private String name;
    private int coins;
    private ArrayList<String> chores = new ArrayList<String>();

    public Team(String n, int num){
        name = n;
        number = num;
        //ToDo: Remember to update!
        coins = 493+72*29+392;
    }

    public void buyChore(String chore, int coins){
        chores.add(chore);
        this.coins -= coins;
    }

    public int getCoins(){return coins;}
    public void setCoins(int coins){this.coins = coins;}

    public boolean canAfford(int amount){
        return coins >= amount;
    }
    public void addChore(String chore){chores.add(chore);}

    public String getName(){return name;}
    public int getNum(){return number;}
    public ArrayList<String> getChores(){return chores;}

    public String toString(){
        String s = number + " " + name + " " + getCoinString();

        for(String c : chores){
            s += " " + c;
        }

        return s;
    }

    public String getCoinString(){
        //ToDo: A high valuta is worth 493 this year. should be changed!
        int high = (int)Math.floor(coins/493);
        //ToDo: A mid valuta is worth 29 this year. should be changed!
        int mid = (int)Math.floor((coins%493)/29);
        int low = (coins%493)%29;

        return high + "." + mid + "." + low;
    }

    public String getLogOutput(){
        return number + ";" + name + ";" + coins;
    }
}
