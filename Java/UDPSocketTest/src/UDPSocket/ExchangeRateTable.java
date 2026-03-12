package UDPSocket;

import java.io.*;
import java.net.*;
import java.util.*;

public class ExchangeRateTable {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter port (nnn): ");
        int port = 10000 + scanner.nextInt();
        scanner.close();

        try (DatagramSocket clientSocket = new DatagramSocket()) {
            InetAddress serverAddress = InetAddress.getByName("localhost");
            
            while (true) {
                byte[] sendData = new byte[1024];
                DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, serverAddress, port);
                clientSocket.send(sendPacket);
                byte[] receiveData = new byte[1024];
                DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
                clientSocket.receive(receivePacket);

                String response = new String(receivePacket.getData(), 0, receivePacket.getLength());
                System.out.println(response);
                Thread.sleep(1000);
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}

