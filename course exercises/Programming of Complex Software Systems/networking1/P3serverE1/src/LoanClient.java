import java.io.*;
import java.net.Socket;
import java.util.Scanner;

public class LoanClient {
double annualInterestRate;
int numberOfYears;
int userLoanAmount;


	
	public static void main(String[] args) {

		int port = 8000;
		String host = "localHost";
		DataInputStream in;
		DataOutputStream out;
		//Socket socket;
		boolean connect = true;
		
		Scanner input = new Scanner(System.in);
	try {
		Socket connectToServer = new Socket(host,port);
		
		DataInputStream isFromServer = new DataInputStream(connectToServer.getInputStream());
		
		DataOutputStream osFromServer = new DataOutputStream(connectToServer.getOutputStream());
		
		while(connect)
		
		//creating scanner object
			
	//Enter amount to loan
	System.out.print("Please enter the loan amount you want to put in: ");
	int loanAmount = input.nextInt();
	//Enter numbers of years
	System.out.print("Please enter the number of years: ");
	double numYears = input.nextInt();
	//Enter Interest rate
	System.out.print("Please enter the annual interest rate: ");
	double annualRate = input.nextDouble();	
	
	osToServer.writeDouble(annualInteresRate);
	
	
	osToServer.writeInt(numyears);
	
	osToServer.writeInt(loanAmount);
	
		}
	catch  (Exception e) {
	System.out.println("error occoured try again");
		}
	
		//print values from server
	// print "types yes to continue or write no for stop
	// if (input.next()equals("no"))
	//connect = false;
	//input.close();
	//connectToServer.close();
	//here the catch at the end
	
	
	
	}
	
	
}




//user input and bank information is printed out at the end.